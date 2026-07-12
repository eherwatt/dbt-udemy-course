This is a Student Repository for the Udemy's Complete dbt Bootcamp. You can:

1. Either start a codespace and start using dbt right away
2. Or clone this repo with Visual Studio Code and follow the instructions to set up a local dbt environment.

Codespace setup:
<img width="930" height="435" alt="image" src="https://github.com/user-attachments/assets/d7e15ad5-6df6-4651-895a-ea382c4da79c" />

_Note: You don't need to create/activate a virtualenv in the Codespace. Everything has been set up for you._

Have fun! :)  
Running the Airbnb dbt project locally

---

1. Source the environment file from the repository root:
   ```bash
   . ./set-env.sh
   ```
2. Change into the `airbnb` project and run dbt with the local wrapper:
   ```bash
   cd airbnb
   ./dbt.sh run
   ```

The repo now includes a root `profiles.yml` and a local wrapper script `airbnb/dbt.sh`, so you can run dbt from inside `airbnb` without manually passing `--profiles-dir`.

The repo now includes a root `profiles.yml`, so `dbt` can load the profile automatically when `DBT_PROFILES_DIR` is set.
