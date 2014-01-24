using System; using System.Collections.Generic; using System.Linq; using System.Data; using System.Text; using Newtonsoft.Json; using Newtonsoft.Json.Linq; using System.IO;

namespace API { class API { public String Command(String[] arg) {
            using (StreamReader reader = File.OpenText(@"../source.json")) {
                DataSet ds = JsonConvert.DeserializeObject<DataSet>(File.ReadAllText(@"../source.json"));
                DataTable dt = ds.Tables[0];
                string s = "";
                switch (arg[0]) { case "entries":
                        foreach (DataRow r in dt.Rows) { 
                            s += 
                                (r["country"] + " has " + r["first_ip"] + " to " + r["last_ip"] + "\n"); }
                        break; case "list":
                        foreach (DataRow r in dt.Rows)
                        {
                            if (r["country"] == arg[1])
                            {
                                string[] asa = r["first_ip"].ToString().Split('.');
                                for (int i = 0; i < 255; i++)
                                {
                                    asa[3] = i.ToString();
                                    s += asa[0] + "." + asa[1] + "." + asa[2] + "." + asa[3];
                                    
                                }
                            }
                        }
                        break; case "locate":
                        foreach (DataRow r in dt.Rows) { string[] asa = r["first_ip"].ToString().Split('.'); for(int i = 0; i < 255; i++) {
                                asa[3] = i.ToString(); if (asa[0] + "." + asa[1] + "." + asa[2] + "." + asa[3] == arg[1])
                                { s += r["country"]; } } }
                        break; default: s += "Commands: entries, locate [ip], list [country]"; break;
                } return s; }
        }
    } }
