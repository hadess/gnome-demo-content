#!/usr/bin/python3


from pathlib import Path
import subprocess
import sys

from gi.repository import GLib, Gio


NICK = 'gnometest'
CHANNELS = ['#gnomefr', '#newcomers']

account = f'idle/irc/{NICK}0'


def write_config():
    config_home = Path(GLib.get_user_data_dir())
    config_path = config_home / 'telepathy' / 'mission-control' / 'accounts.cfg'

    if config_path.exists():
        raise FileExistsError(config_path)

    config_path.parent.mkdir(parents=True, exist_ok=True)
    config_path.write_text(
        f'[{account}]\n'
        'manager=idle\n'
        'protocol=irc\n'
        'DisplayName=GNOME\n'
        'Enabled=true\n'
        'Service=gimpnet\n'
        f'param-account={NICK}\n'
        'param-server=irc.acc.umu.se\n'
        'param-use-ssl=true\n'
        'param-port=6697\n')


def write_settings(channels=None):
    if channels:
        channels = [f'#{c}' for c in channels]

    else:
        channels = CHANNELS

    account_path = f'/org/freedesktop/Telepathy/Account/{account}'
    saved_channels = [
        {
            'account': GLib.Variant('s', account_path),
            'channel': GLib.Variant('s', c),
        }
        for c in channels
    ]

    subprocess.call(['pkill', 'mission-control'])
    settings = Gio.Settings(schema_id='org.gnome.Polari')
    settings.set_value('saved-channel-list', GLib.Variant('aa{sv}', saved_channels))


if __name__ == '__main__':
    try:
        write_config()

    except FileExistsError:
        print('Found existing telepathy configuration, not doing anything.')
        sys.exit(0)

    write_settings(channels=sys.argv[1:])
