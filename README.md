# fuas

or Fedora User Activity Statistics

Automatically gather and update the statistics of active users in Fedora Project over the course of last given period of time

## Usage

1. Install `curl` on your Fedora Linux installation, if not installed already.
   ```
   sudo dnf install curl
   ```
2. Obtain a list of available usernames by executing the following command.
   ```
   curl https://raw.githubusercontent.com/t0xic0der/fuas/main/data/namefile -o /var/tmp/namefile
   ```
3. Obtain a list of active usernames by executing the following command.
   ```
   curl https://raw.githubusercontent.com/t0xic0der/fuas/main/data/actvfile -o /var/tmp/actvfile
   ```
4. Obtain the number of active usernames by executing the following command.
   ```
   echo "$(curl https://raw.githubusercontent.com/t0xic0der/fuas/main/data/acqtfile) usernames active"
   ```

## Development

1. Install Python 3, Virtualenv, PIP and Poetry on your Fedora Linux installation.
   ```
   $ sudo dnf install python3 python3-virtualenv python3-pip poetry
   ```
2. Clone the repository to your local storage and make it your present working directory.
   ```
   $ git clone https://github.com/t0xic0der/fuas.git
   $ cd fuas
   ```
3. Set up and activate a virtual environment within the directory of the cloned repository.
   ```
   $ virtualenv venv
   $ source venv/bin/activate
   ```
4. Check the validity of the project configuration and install the project dependencies from the lockfile.
   ```
   $ (venv) poetry check
   $ (venv) poetry install
   ```
5. Execute the following command to view the help message.
   ```
   $ (venv) fuas --help
   ```
   Output
   ```
   Usage: fuas [OPTIONS] COMMAND [ARGS]...

   Options:
     --version  Show the version and exit.
     --help     Show this message and exit.

   Commands:
     activity  Fetch a list of active usernames from Datagrepper
     namelist  Fetch a list of usernames on the Fedora Account System
   ```
6. Execute the following command to view the project version.
   ```
   $ (venv) fuas --version
   ```
   Output
   ```
   fuas, version 0.1.0
   ```
7. Make necessary changes to the variables located in the `fuas/conf.py` file, following the instructions.
   ```
   $ (venv) nano fuas/conf.py
   ```
8. Fetch and store the list of available usernames locally by executing the following command.
   ```
   $ (venv) fuas namelist
   ```
   As this command makes a long-running and resource intensive request to the FASJSON service, it is strongly 
   recommended to not run this command manually and instead rely on the automatically updated list in the 
   project repository by using the 2nd step of the **Usage** section.
9. Fetch and store the list and count of active usernames by executing the following command.
   ```
   $ (venv) fuas activity
   ```
   As this command makes a long-running and resource intensive request to the Datagrepper service, it is strongly 
   recommended to not run this command manually and instead rely on the automatically updated list and count in the 
   project repository by using the 3rd and 4th steps of the **Usage** section.
