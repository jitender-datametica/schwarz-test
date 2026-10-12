/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site
Description		| All sites that are known, e.g. central warehouses, cross-docks or supplier sites
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_site(
	site_sid COMMENT 'The unique identifier (surrogate key) for the site.',
	dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.',
	dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.',
	dwh_valid_fg COMMENT 'An indicator showing the current record in history.',
	site_nr COMMENT 'A numeric or alphanumeric value which identifies the site for the business.',
	site_abbr_name COMMENT 'A short abbreviation for the site that identifies it.',
	site_name COMMENT 'The name by which the site is known.',
	site_type_cd COMMENT 'The code for the type of site e.g. TRANS = Warenumschlagplatz.',
	site_type_descr COMMENT 'A textual description for the site_type_cd written out in group language (German).',
	country_cd COMMENT 'The code for the country to which t_site references on. ',
	country_descr COMMENT 'A textual description for country_cd written out in group language (German).',
	longitude COMMENT 'Object.address-data.coordinates x',
	latitude COMMENT 'Object.address-data.coordinates y',
	city_name COMMENT 'Name of the city',
	zip COMMENT 'Zip code / PLZ',
	street_name COMMENT 'Name of the street',
	transpoint_type_cd COMMENT 'The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.',
	transpoint_type_descr COMMENT 'A textual description for the transpoint_type_cd written out in group language (German).',
	site_status_cd COMMENT 'The code for the status of the site.',
	site_status_descr COMMENT 'A textual description for the site_status_cd written out in group language (German).',
	gln_nr COMMENT 'The Global Location Number (GLN) is part of the GS1 systems of standards. It is a simple tool used to identify a location and can identify locations uniquely where required.',
	site_operator_sid COMMENT 'The unique identifier (surrogate key) for the site operator. Either its operated by internal organization or external party. ',
	external_wh_fg COMMENT 'An indicator showing whether the warehouse is an external one to add capacity to a central warehouse.'
) COMMENT='This dimension contains all sites that are known, e.g. central warehouses, cross-docks or supplier sites where products are collected by the hauler'
 AS 
SELECT
   site_sid
  ,dwh_valid_from_tmsp
  ,dwh_valid_to_tmsp
  ,dwh_valid_fg
  ,site_nr
  ,site_abbr_name
  ,site_name
  ,site_type_cd
  ,site_type_descr
  ,country_cd
  ,country_descr
  ,longitude
  ,latitude
  ,city_name
  ,zip
  ,street_name
  ,transpoint_type_cd
  ,transpoint_type_descr
  ,site_status_cd
  ,site_status_descr
  ,gln_nr
  ,site_operator_sid
  ,external_wh_fg
FROM core.t_dim_site
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;