# Bootstrapping Pass
First you need to create a gpg key:

```bash
gpg2 --full-gen-key
```

You go through some prompts that request basic metadata. Set up a passphrase. When you're done, initialize pass:

```bash
pass init email.address@domain.com
```

where the email is the one that was set during gpg key generation. To enable git password storage, create an entry at `git/credential`. It should follow the format:

```
username=usernamegoeshere
password=passwordgoeshere
```
