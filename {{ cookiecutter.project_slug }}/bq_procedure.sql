CREATE OR REPLACE PROCEDURE `{{ cookiecutter.procedure_slug()`
OPTIONS (strict_mode=FALSE)
BEGIN
/* TODO variable declarations to make this dynamic */
/*
declare
  table name
  view
  append or replace
  partition array
  cluster array
*/

CREATE TEMP TABLE temp_table AS
  SELECT
    *
  FROM
    `{{ cookiecutter.view_slug }}`
/* TODO make this a conditional */
TRUNCATE TABLE
  `{{ cookiecutter.table_slug }}`;
INSERT INTO
  `{{ cookiecutter.table_slug }}`
  SELECT
    *
  FROM
    `{{ cookiecutter.view_slug }}`;
/* TODO this is for a replacement if partition definition changes */
EXCEPTION WHEN ERROR THEN
  DROP TABLE IF EXISTS `{{ cookiecutter.table_slug }}`
  CREATE OR REPLACE TABLE `{{ cookiecutter.table_slug }}`
    -- PARTITION BY a
    -- CLUSTER BY b
  AS
  SELECT * FROM temp_table;
END;

