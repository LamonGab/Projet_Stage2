using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;

namespace API_SIGMA
{
    class Token
    {
        HttpClient client = new HttpClient();
        string url;
        HttpResponseMessage reponse;
        string token;
        int[] intToken;

        public Token(string ent, string cli, string user, string pswd, string url) {
            this.url = url;

            //Donnees d'authentification
            var authentification = new
            {
                enterprise = ent,
                client = cli,
                userLogin = user,
                password = pswd
            };

            //Convertir en JSON
            var json = JsonConvert.SerializeObject(authentification);
            StringContent donnees = new StringContent(json, Encoding.UTF8, "application/json");

            //Appel de la tache postAuth
            postAuth(url, donnees).GetAwaiter().GetResult();

            //Verification de l'obtention du token
            requestIsSuccessful(this.reponse);

            //Convertir le token en tableau d'entier pour les prochaines requetes
            stringToIntArray();
        }

        //Envoi de la requete POST authenticate a l'API
        private async Task postAuth(string url, StringContent donnees)
        {
            this.reponse = await client.PostAsync(url, donnees);
        }

        //Converti la reponse en string
        private async Task toString(HttpResponseMessage reponse)
        {
            this.token = await reponse.Content.ReadAsStringAsync();
        }

        private void requestIsSuccessful(HttpResponseMessage reponse)
        {
            if (this.reponse.IsSuccessStatusCode)
            {
                Console.WriteLine("Authentification reussie");
                toString(this.reponse).GetAwaiter().GetResult();
            }
            else
            {
                Console.WriteLine("Erreur lors de l'authentification");
                toString(this.reponse).GetAwaiter().GetResult();
            }
        }

        //Converti le token en tableau d'entiers
        private void stringToIntArray()
        {
            //Retir les crochets
            string jeton = this.token.Trim('[', ']');
            
            //Divise la chaine en sous-chaines par la virgule
            string[] values = jeton.Split(',');

            //Convertir en tableau d'entier
            this.intToken = Array.ConvertAll(values, int.Parse);
        }

        //Retourne la valeur du token
        public int[] getIntToken()
        {
            return this.intToken;
        }

        public string getToken()
        {
            return this.token;
        }
    }
}
