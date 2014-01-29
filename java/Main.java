import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import com.google.gson.Gson;


public class Main {
	public static void main(String[] args) throws IOException{
		File json = new File("source.json");
		FileReader fr = new FileReader(json);
		int r = 0;
		String jsonString = "";
		while ((r = fr.read()) != -1){
			jsonString += (char)r;
		}
		Gson gson = new Gson();
		GData[] data = gson.fromJson(jsonString, GData[].class);
		if (args[0].equals("list")){
			for (GData dat : data){
				if (!dat.country.equals(args[1])) continue;
				String[] split = dat.first_ip.replace(".", ":").split(":");
				int i = (Integer.parseInt(split[0]) << 24) | (Integer.parseInt(split[1]) << 16)  |  (Integer.parseInt(split[2]) << 8) | (Integer.parseInt(split[3]));
				String[] split2 = dat.first_ip.replace(".", ":").split(":");
				int j = (Integer.parseInt(split2[0]) << 24) | (Integer.parseInt(split[1]) << 16)  |  (Integer.parseInt(split2[2]) << 8) | (Integer.parseInt(split2[3]));
				while (i < j){
					System.out.println(""+((i >> 24) & 0xF)+"."+((i >> 16) & 0xFF)+"."+((i >> 8) & 0xFF)+"."+((i) & 0xFF));
					i++;
				}
			}
		}
		if (args[0].equals("entries")){
			for (GData dat : data){
				System.out.println(dat.country+" firstip: "+dat.first_ip+" lastip: "+dat.last_ip);
			}
		}
		if (args[0].equals("locate")){
			for (GData dat : data){
				String[] split = args[1].replace(".", ":").split(":");
				int i = (Integer.parseInt(split[0]) << 24) | (Integer.parseInt(split[1]) << 16)  |  (Integer.parseInt(split[2]) << 8) | (Integer.parseInt(split[3]));
				String[] split2 = dat.first_ip.replace(".", ":").split(":");
				int j = (Integer.parseInt(split2[0]) << 24) | (Integer.parseInt(split2[1]) << 16)  |  (Integer.parseInt(split2[2]) << 8) | (Integer.parseInt(split2[3]));
				String[] split3 = dat.first_ip.replace(".", ":").split(":");
				int k = (Integer.parseInt(split3[0]) << 24) | (Integer.parseInt(split[31]) << 16)  |  (Integer.parseInt(split3[2]) << 8) | (Integer.parseInt(split3[3]));
				if (i <= k && i >= j){
					System.out.println(dat.country);
				}
			}
		}
		if (args[0].equals("help")){
			System.out.println("locate [ip], list [country], entries");
		}
	}
	public static class GData{
		public String first_ip, last_ip, country;
	}
}
