# Why?

I recently ran into an issue on Docker Swarm and did have backups in place for my [BookstackApp instance](https://www.bookstackapp.com/), so I wrote a small bash script to help me out. Thought it might help someone else in the future. Really elementary my dear Watson.

All the variables used are listed in the file itself. 

Enjoy!

# How?

To be done on each Docker Swarm node where your apps might end up running: 
- Clone this down, copy the shell script to a directory of your choice and make sure it has executable rights with `chmod +x`. 
- Edit the variables inside the file to reflect your own environment. 
- Edit crontab to run this shell script at a time convenient to you.
