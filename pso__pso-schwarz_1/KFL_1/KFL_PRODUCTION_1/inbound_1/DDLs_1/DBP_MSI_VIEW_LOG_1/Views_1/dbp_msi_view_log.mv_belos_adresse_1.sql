CREATE OR REPLACE VIEW dbp_msi_view_log.mv_belos_adresse_1
--02.03.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_1
-- AP0112140_SPEC0155506, dknop, adding dummy_1 records for 'K-NA'
--2022-09-22, AP0112140_SPEC0155506, dknop, updating dummy_1 records form 'K-NA' to Dachser'
--2022-12-01, dknop, updating dummy_1 records form 'Dachser' to Dachser SE'
--2023-01-05,  dknop, removing dummy_1 records
AS
SELECT
v01.mandant_id,
v01.belos_adresse_id,
v01.land_id,
v01.adress_name,
v01.adress_name_zusatz,
v01.strasse,
v01.be_entlade_stelle,
v01.plz,
v01.ansprechpartner,
v01.ort,
v01.spedition_fg,
v01.belos_standort_typ_id,
v01.belos_adresse_num_id
FROM dbp_view.v_belos_adresse_1 v01

;