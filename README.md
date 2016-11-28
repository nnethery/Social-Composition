# Social Composition
Social Composition is a project for a class on the Max/MSP software from Cycling '74, taught by Dr. Clifton Callender at Florida State University. This project downloads and stores data from Facebook profiles in a database and builds a unique musical composition for each user. Then, the every user's composition becomes a single voice in a "dynamic canon." As more users participate in the project, the canon grows accordingly. This project is in two parts:
### iPhone App
For an easy user experience, the data aggregation is happening on an iPhone being passed around the classroom. A user signs in through Facebook, and then is authorized with a Firebase realtime database. Public data elements like name, birthday, and friend list, etc. are recorded and uploaded to the database.
### Max Patch
Inside of the Max project, a curl of the database happens and the downloaded JSON is parsed. That data is used in various synthesizers and modules to create the composition. The composition is bounced, compressed, and uploaded back to the database to be stored with the user. Another section of the patch refreshes all of the compositions stored and recompiles the canon.
