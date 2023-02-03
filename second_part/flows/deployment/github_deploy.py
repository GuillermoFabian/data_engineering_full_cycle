from prefect.deployments import Deployment
from etl_web_to_gcs_nov_2020 import etl_web_to_gcs
from prefect.filesystems import GitHub

github_block = GitHub.load("github-repo")

github_dep = Deployment.build_from_flow(
     flow=etl_web_to_gcs,
     name="github-example",
     storage=github_block,
     entrypoint="second_part/flows/deployment/etl_web_to_gcs_Q4.py:etl_web_to_gcs")


if __name__ == "__main__":
    github_dep.apply()