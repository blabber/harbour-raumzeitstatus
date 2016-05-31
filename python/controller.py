# "THE BEER-WARE LICENSE" (Revision 42):
# <tobias.rehbein@web.de> wrote this file. As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.
#                                                             Tobias Rehbein

import pyotherside
import threading
import urllib.request
import urllib.error
import ssl

class Controller:
    def __init__(self):
        self.bgthread = threading.Thread()
        self.bgthread.start()

    def refresh(self):
        if self.bgthread.is_alive():
            return

        self.bgthread = threading.Thread(target=self.__refresh_in_background)
        self.bgthread.start()

    def __refresh_in_background(self):
        # FIXME: Disabled SSL verification for now
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE

        s = '?'
        url = 'https://status.raumzeitlabor.de/api/simple.json'

        try:
            with urllib.request.urlopen(url=url, context=ctx) as f:
                s = f.read(1)
        except urllib.error.URLError as err:
            print('Error: {0}'.format(err.reason))
        except urllib.error.HTTPError as err:
            print('Error: {0}: {1}'.format(err.code, err.reason))

        pyotherside.send('finished', s) 

instance = Controller()

