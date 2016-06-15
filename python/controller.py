# "THE BEER-WARE LICENSE" (Revision 42):
# <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.
#                                                             Tobias Rehbein

import pyotherside
import threading
import urllib.request
import urllib.error
import os
import os.path
import json
import ssl

class Controller:
    def __init__(self):
        self.bgthread = threading.Thread()
        self.bgthread.start()

        home = os.path.expanduser('~')

        xdg_config_home = os.environ.get('XDG_CONFIG_HOME', os.path.join(home, '.config'))
        self.config_file = os.path.join(xdg_config_home, "harbour-raumzeitstatus", "config.json")
        self.config_loaded = False

    def load_config(self):
        if not os.path.exists(self.config_file):
            return

        with open(self.config_file, 'r') as f:
            c = json.load(f)

        if c:
            pyotherside.send('configLoaded', c)

    def save_config(self, config):
        os.makedirs(os.path.dirname(self.config_file), exist_ok=True)

        with open(self.config_file, 'w') as f:
            json.dump(config, f, indent=2)

    def get_status_from_backend(self):
        # Certificate verficiation fails on Sailfish OS 2.0.1.11. After several
        # tests with openssl s_client and curl it seems as if some certificate
        # in the chain is missing in the system set of trusted certificates.
        # Disable certificate verification. As this app only displays status
        # information MITM can be ignored.
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE

        s = '?'
        url = 'https://status.raumzeitlabor.de/api/simple.json'

        try:
            with urllib.request.urlopen(url=url, timeout=10, context=ctx) as f:
                s = f.read(1)
        except urllib.error.URLError as err:
            print('Error: {0}'.format(err.reason))
        except urllib.error.HTTPError as err:
            print('Error: {0}: {1}'.format(err.code, err.reason))

        pyotherside.send('statusRefreshed', s)

    def refresh(self):
        if self.bgthread.is_alive():
            return

        self.bgthread = threading.Thread(target=self.__refresh_in_background)
        self.bgthread.start()

    def __refresh_in_background(self):
        self.get_status_from_backend()
        if not self.config_loaded:
            self.load_config()
            self.config_loaded = True

instance = Controller()

