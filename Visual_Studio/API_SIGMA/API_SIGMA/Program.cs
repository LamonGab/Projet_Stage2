using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Net.Http;

class Program{
    static void Main(string[] args){

        //Variables authentification
        string authUrl = "https://siurhsst.sigma-rh.net/siurhsst/webservices/restauthentication.svc/authenticate";
        string enterprise = "siurhsst";
        string client = "msss_ws";
        string userLogin = "username";
        string password = "password";
        int[] jeton;

        //Obtention du jeton d'authentification
        API_SIGMA.Token token = new API_SIGMA.Token(enterprise, client, userLogin, password, authUrl);
        jeton = token.getIntToken();
        Console.WriteLine("Token: " + token.getToken());

        //Variables getdata
        string dataUrl = "https://siurhsst.sigma-rh.net/siurhsst/webservices/restdataquery.svc/getdata";
        string dataSource;
        DateTime dateTime = DateTime.Now;
        API_SIGMA.FilterDate filterDate = new API_SIGMA.FilterDate(dateTime);
        int day = 86400000;
        int hour = 3600000;
        int minute = 60000;
        string dataResult;
        long dateDebutMilliseconds;
        long dateFinMilliseconds;

        //Boucle pour aller chercher tous les rapports
        //Les numeros de rapports sont compris entre 62 et 73
        for (int i = 62; i < 73; i++)
        {
            //Boucle pour faire 25 itérations d'appels d'API dans le but de découper l'appel en plusieurs blocs
            //Raison de cette utilisation: La requête des rapports complets peuvent être trop lourdes en fonction du niveau d'activité du webservice
            for (int iteration = 0; iteration < 25; iteration++)
            {
                dateDebutMilliseconds = filterDate.getTime() - ((iteration + 1) * 30 * day + 0 * hour + 0 * minute);
                dateFinMilliseconds = filterDate.getTime() - (iteration * 30 * day + 0 * hour + 0 * minute);

                //Contenu de l'argument
                var argumentStructureDebut = new API_SIGMA.Arguments
                {
                    __type = "DateArgument:#Sigma.SigmaRH.Web.Common.WebServices.DataQuery",
                    name = "DateDébut",
                    value = "\\/Date(" + dateDebutMilliseconds + ")\\/"
                };
                var argumentStructureFin = new API_SIGMA.Arguments
                {
                    __type = "DateArgument:#Sigma.SigmaRH.Web.Common.WebServices.DataQuery",
                    name = "DateFin",
                    value = "\\/Date(" + dateFinMilliseconds + ")\\/"
                };
                string argument = JsonConvert.SerializeObject(new[] { argumentStructureDebut, argumentStructureFin });

                dataSource = i.ToString();

                //Requete de donnees
                API_SIGMA.Data data = new API_SIGMA.Data(jeton, dataSource, dataUrl, iteration, argument);
                dataResult = data.getData();

                //Choix du nom du fichier en fonction du rapport extrait
                string fileName = data.getFileName(dataSource);

                //Sauvegarde d'un fichier csv
                API_SIGMA.CsvFile csvFile = new API_SIGMA.CsvFile(dataResult, fileName, iteration);
            }
        }
    }
}