using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using Microsoft.VisualBasic;

namespace API_SIGMA
{
    class Data
    {
        HttpClient client = new HttpClient
        {
            Timeout = TimeSpan.FromMinutes(10)
        };
        string url;
        HttpResponseMessage reponse;
        string data;

        public Data(int[] token, string dataSource, string url, int? iteration = null, string arguments = "")
        {
            this.url = url;
            dynamic data;

            //Donnes pour le getData
            if (arguments == "")
            {
                data = new
                {
                    authenticationToken = token,
                    dataSource = dataSource
                };
            }
            else
            {
                data = new
                {
                    authenticationToken = token,
                    dataSource = dataSource,
                    //Utilise la variable comme un objet JSON
                    arguments = JRaw.Parse(arguments)
                };
            }

            //Convertir en JSON
            var json = JsonConvert.SerializeObject(data);
            //Pour enlever des '\' qui se mettent en trop du a la nomenclature C#
            json = json.Replace("\\\\", "&");
            json = json.Replace("\\", "");
            json = json.Replace("&", "\\");
            StringContent donnees = new StringContent(json, Encoding.UTF8, "application/json");

            //Execution de la requête
            getData(donnees, url).GetAwaiter().GetResult();

            //Verification de l'obtention des donnees
            requestIsSuccessful(this.reponse, dataSource, iteration);
        }

        private async Task getData(StringContent donnees, string url)
        {
            this.reponse = await client.PostAsync(url, donnees);
        }

        private async Task toString(HttpResponseMessage reponse)
        {
            this.data = await reponse.Content.ReadAsStringAsync();
        }

        private void requestIsSuccessful(HttpResponseMessage reponse, string dataSource, int? iteration)
        {
            if (iteration != null)
            {
                if (reponse.IsSuccessStatusCode)
                {
                    Console.WriteLine("Requete " + (iteration + 1) + " vers le rapport " + dataSource + " a reussie");
                    toString(reponse).GetAwaiter().GetResult();
                }
                else
                {
                    Console.WriteLine("Requete " + (iteration + 1) + " vers le rapport " + dataSource + " a echoue");
                    toString(reponse).GetAwaiter().GetResult();
                }
            }
            else
            {
                if (reponse.IsSuccessStatusCode)
                {
                    Console.WriteLine("Requete vers le rapport " + dataSource + " a reussie");
                    toString(reponse).GetAwaiter().GetResult();
                }
                else
                {
                    Console.WriteLine("Requete vers le rapport " + dataSource + " a echoue");
                    toString(reponse).GetAwaiter().GetResult();
                }
            }
        }

        //Choisi le nom du fichier en fonction du rapport extrait
        public string getFileName(string dataSource)
        {
            string fileName;

            switch (dataSource)
            {
                case "62":
                    fileName = "Absence.csv";
                    break;

                case "63":
                    fileName = "Rapport_accident.csv";
                    break;

                case "64":
                    fileName = "PMSD.csv";
                    break;

                case "65":
                    fileName = "Declaration_incident_Accident.csv";
                    break;

                case "66":
                    fileName = "Absenteisme_eleve.csv";
                    break;

                case "67":
                    fileName = "Diagnostic_Rapport_accident.csv";
                    break;

                case "68":
                    fileName = "Evaluation_medicale.csv";
                    break;

                case "69":
                    fileName = "Limitation_fonctionnelle.csv";
                    break;

                case "70":
                    fileName = "Consequence_Rapport_accident.csv";
                    break;

                case "71":
                    fileName = "Diagnostic_Absence.csv";
                    break;

                case "72":
                    fileName = "Consequence_Absence.csv";
                    break;

                default:
                    fileName = "Rapport_non_enregistre.csv";
                    break;
            }

            return fileName;
        }

        public String getData()
        { 
            return this.data;
        }
    }
}
