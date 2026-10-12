/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_operator_2
Description		| All companies that we interact with, e.g. Supplier_2 and Hauler and Warehouse Org Units
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_site_operator_2(
	site_operator_sid COMMENT 'The unique identifier (surrogate key) for the site operator.',
	dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.',
	dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.',
	dwh_valid_fg COMMENT 'An indicator showing the current record in history.',
	site_operator_nr COMMENT 'A numeric or alphanumeric value which identifies the company for the business.',
	site_operator_abbr_name COMMENT 'A short abbreviation for the company that identifies it.',
	site_operator_short_name COMMENT 'Short name for company. On CARGO side = <Kurzbezeichnung>',
	site_operator_name COMMENT 'The name by which the company is known.',
	site_operator_status_cd COMMENT 'The code for the status_2 of the company. (column  will likely be deleted and table doesn''t exist on SF)',
	supplier_fg COMMENT 'An indicator showing whether the site operator acts as a supplier_2 for us.',
	hauler_fg COMMENT 'An indicator showing whether the site operator acts as a hauler for us.',
	org_unit_fg COMMENT 'An indicator showing whether the site operator acts as a org unit_2 for us.',
	vat_nr COMMENT 'The vat number (Umsatzsteuer ID). '
) COMMENT='This dimension contains all companies that we interact with, e.g. Supplier_2 and Hauler and Warehouse Org Units'
 AS 
 SELECT
   site_operator_sid
  ,dwh_valid_from_tmsp
  ,dwh_valid_to_tmsp
  ,dwh_valid_fg
  ,site_operator_nr
  ,site_operator_abbr_name
  ,site_operator_short_name
  ,site_operator_name
  ,site_operator_status_cd
  ,supplier_fg
  ,hauler_fg
  ,org_unit_fg
  ,vat_nr
FROM core.t_dim_site_operator_2
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;