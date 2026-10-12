/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_operator_1
Description		| All companies that we interact with, e.g. Supplier_1 and Hauler and Warehouse Org Units
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_site_operator_1 (site_operator_sid
OPTIONS(description='The unique identifier (surrogate key) for the site operator.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record in history.'), site_operator_nr
OPTIONS(description='A numeric or alphanumeric value which identifies the company for the business.'),
site_operator_abbr_name OPTIONS(description='A short abbreviation for the company that identifies it.'),
site_operator_short_name OPTIONS(description='Short name for company. On CARGO side = <Kurzbezeichnung>'),
site_operator_name OPTIONS(description='The name by which the company is known.'), site_operator_status_cd
OPTIONS(description='The code for the status_1 of the company. (column  will likely be deleted and table doesn\'t exist on SF)'),
supplier_fg OPTIONS(description='An indicator showing whether the site operator acts as a supplier_1 for us.'), hauler_fg
OPTIONS(description='An indicator showing whether the site operator acts as a hauler for us.'), org_unit_fg
OPTIONS(description='An indicator showing whether the site operator acts as a org unit_1 for us.'), vat_nr
OPTIONS(description='The vat number (Umsatzsteuer ID). '))
OPTIONS(DESCRIPTION = `THIS DIMENSION CONTAINS ALL COMPANIES THAT WE INTERACT WITH, E.G. SUPPLIER_1 AND HAULER AND WAREHOUSE ORG UNITS`)
AS SELECT site_operator_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 site_operator_nr,
 site_operator_abbr_name,
 site_operator_short_name,
 site_operator_name,
 site_operator_status_cd,
 supplier_fg,
 hauler_fg,
 org_unit_fg,
 vat_nr
FROM ldl_score_core.t_dim_site_operator_1
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;