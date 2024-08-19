using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using CsvHelper;
using CsvHelper.Configuration;
using Newtonsoft.Json;

namespace API_SIGMA
{
    public class Column
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class Valeur
    {
        public int Col { get; set; }
        public string Value { get; set; }
    }

    public class Row
    {
        public List<Valeur> Values { get; set; }
    }

    public class RootObject
    {
        public List<Column> Columns { get; set; }
        public List<Row> Rows { get; set; }
    }


    class CsvFile
    {
        string reponseApi;
        string folderPath = @"\\infocentreDB-t\INFOCENTRE\RH_DB\EXE\CSV";
        string filePath;
        RootObject rootObject;

        public CsvFile (string reponseApi, string fileName, int? premiereIteration = null)
        {
            this.reponseApi = reponseApi;
            this.filePath = Path.Combine(this.folderPath, fileName);

            //Convertir le format JSON en liste d'objets
            this.rootObject = JsonConvert.DeserializeObject<RootObject>(this.reponseApi);

            //Ecriture des donnees dans un .csv
            jsonStringToCsv(this.rootObject, premiereIteration);
        }

        //Passe d'un string sous format de tableau JSON a un .csv
        //Cree le fichier .csv s'il est non-existant
        private void jsonStringToCsv(RootObject rootObject, int? premiereIteration)
        {
            if (premiereIteration == 0 || premiereIteration == null)
            {
                using (var writer = new StreamWriter(filePath))
                {
                    //Titres de colonnes
                    writer.WriteLine(string.Join('\\', rootObject.Columns.Select(c => c.Name)));

                    //Contenu des colonnes
                    foreach (var row in rootObject.Rows)
                    {
                        writer.WriteLine(string.Join('\\', row.Values.OrderBy(v => v.Col).Select(v => v.Value)));
                    }
                }
            }
            else
            {
                using (var writer = new StreamWriter(filePath, true))
                {
                    //Contenu des colonnes
                    foreach (var row in rootObject.Rows)
                    {
                        writer.WriteLine(string.Join('\\', row.Values.OrderBy(v => v.Col).Select(v => v.Value)));
                    }
                }
            }
            Console.WriteLine("Ecriture du .csv reussie");
        }

        //Afficher les donnees deserialisees pour verification
        public void printReport(RootObject rootObject)
        {
            foreach (var column in rootObject.Columns)
            {
                Console.WriteLine($"Column ID: {column.Id}, Name: {column.Name}");
            }

            int index = 0;
            foreach (var row in rootObject.Rows)
            {
                index++;
                Console.WriteLine("Row " + index + " values:");
                foreach (var value in row.Values)
                {
                    Console.WriteLine($"Col: {value.Col}, Value: {value.Value}");
                }
            }
        }
    }
}
