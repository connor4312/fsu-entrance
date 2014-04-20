#FSU Entrance "Exam" ![](http://img.shields.io/badge/unicorn-approved-ff69b4.svg)

Hello developer, and thanks for your interest in applying to FSU. We have a task for you (aren't you lucky?). Contained within the subdirectories are ugly CLI programs in a variety of languages, that provide an API for basic geolocation based on the first thirty entries in the MaxMind Lite database, in `/source.json`.

Each of these allow you to:

 * List all available GeoIP entries
 * Geolocate an IP to its country
 * Retrieve and list the IPs assigned to each country

If one doesn't exist in your preferred language, feel free to write one! Put in a PR containing your ugly code, and send the "good" code privately to a member of FSU.

Now, all this code works, but is intentionally ugly, unreadable, and generally fundamentally flawed. Your task is to take one of these projects - whatever two languages you feel most comfortable with - and turn them into usable APIs with a CLI interface. You must unit test your application, and bonus points for adding additional nifty features.

Your applications must expose the same external interface as the original application (same commands and arguments), and must be functional. **You must use at least two separate families of languages** - we don't want one-trick unicorns in here! For example, you can complete a version in Java and C# or Python and Ruby, but you cannot complete a version simply in Javascript and Dogescript.

Good luck!
