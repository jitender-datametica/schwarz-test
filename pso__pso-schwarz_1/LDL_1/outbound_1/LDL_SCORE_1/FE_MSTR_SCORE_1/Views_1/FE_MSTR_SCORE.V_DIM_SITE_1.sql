/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_1
Description		| All sites that are known, e.g. central warehouses, cross-docks or supplier_1 sites
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_site_1 (site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record in history.'), site_nr
OPTIONS(description='A numeric or alphanumeric value which identifies the site for the business.'), site_abbr_name
OPTIONS(description='A short abbreviation for the site that identifies it.'), site_name
OPTIONS(description='The name by which the site is known.'), site_type_cd
OPTIONS(description='The code for the type of site e.g. TRANS = Warenumschlagplatz.'), site_type_descr
OPTIONS(description='A textual description for the site_type_cd written out in group language (German).'), country_cd
OPTIONS(description='The code for the country_1 to which t_site_1 references on. '), country_descr
OPTIONS(description='A textual description for country_cd written out in group language (German).'), longitude
OPTIONS(description='Object.address_1-data.coordinates x'), latitude
OPTIONS(description='Object.address_1-data.coordinates y'), city_name OPTIONS(description='Name of the city'), zip
OPTIONS(description='Zip code / PLZ'), street_name OPTIONS(description='Name of the street'), transpoint_type_cd
OPTIONS(description='The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.'),
transpoint_type_descr
OPTIONS(description='A textual description for the transpoint_type_cd written out in group language (German).'),
site_status_cd OPTIONS(description='The code for the status_1 of the site.'), site_status_descr
OPTIONS(description='A textual description for the site_status_cd written out in group language (German).'), gln_nr
OPTIONS(description='The Global Location_1 Number (GLN) is part of the GS1 systems of standards. It is a simple tool used to identify a location_1 and can identify locations uniquely where required.'),
site_operator_sid
OPTIONS(description='The unique identifier (surrogate key) for the site operator. Either its operated by internal organization or external party. '),
external_wh_fg
OPTIONS(description='An indicator showing whether the warehouse is an external one to add capacity to a central warehouse.'))
OPTIONS(DESCRIPTION = `THIS DIMENSION CONTAINS ALL SITES THAT ARE KNOWN, E.G. CENTRAL WAREHOUSES, CROSS-DOCKS OR SUPPLIER_1 SITES WHERE PRODUCTS ARE COLLECTED BY THE HAULER`)
AS SELECT site_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 site_nr,
 site_abbr_name,
 site_name,
 site_type_cd,
 site_type_descr,
 country_cd,
 country_descr,
 longitude,
 latitude,
 city_name,
 zip,
 street_name,
 transpoint_type_cd,
 transpoint_type_descr,
 site_status_cd,
 site_status_descr,
 gln_nr,
 site_operator_sid,
 external_wh_fg
FROM ldl_score_core.t_dim_site_1
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;