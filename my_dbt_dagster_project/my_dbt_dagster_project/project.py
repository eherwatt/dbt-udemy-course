from pathlib import Path

from dagster_dbt import DbtProject
from dotenv import load_dotenv

airbnb_project_dir = Path(__file__).joinpath("..", "..", "..", "airbnb").resolve()
load_dotenv(airbnb_project_dir / ".env")

airbnb_project = DbtProject(
    project_dir=airbnb_project_dir,
    packaged_project_dir=Path(__file__).joinpath("..", "..", "dbt-project").resolve(),
)
airbnb_project.prepare_if_dev()