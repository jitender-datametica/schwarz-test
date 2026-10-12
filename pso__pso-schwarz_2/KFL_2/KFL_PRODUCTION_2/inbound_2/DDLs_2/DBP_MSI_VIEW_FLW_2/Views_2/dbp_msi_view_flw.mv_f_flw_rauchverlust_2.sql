CREATE OR REPLACE VIEW dbp_msi_view_flw.mv_f_flw_rauchverlust_2
-- 20.11.2019 SPEC0054374 Neuanlage
-- 04.05.2020 SPEC0054374 Änderung Tabellenstruktur, Join zu mv_f_flw_bew_2 über speziellen Frontendfilter um passende Kombiniationen zu ermitteln.
--            flw_tenum_rauchprozess_kennzeichen = IN und flw_beleg_typ_id = WA (bzw. OUT mit WE)

(
 mandant_id
,werk_id
,dat_rauchvorgang
,zeit_rauchvorgang
,in_art_id
,rauchwagen_id
,flw_arbeitsplatz1_id
,gewicht_netto_in
,gewicht_netto_out
,basismenge_einh_id
,transport_einheit_id
,flw_tenum_rauchprozess_kennzeichen
,nettogew_diff_in_out
)
AS
SELECT
v01.mandant_id,
v01.werk_id,
v01.dat_rauchvorgang,
v01.zeit_rauchvorgang,
v01.flw_art_id  AS in_art_id,
v01.rauchwagen_id,
v01.flw_arbeitsplatz1_id,
v01.nettogew_in AS gewicht_netto_in,
v01.nettogew_out AS gewicht_netto_out,
v01.basismenge_einh_id,
v01.transport_einheit_id,
v01.flw_tenum_rauchprozess_kennzeichen,
v01.nettogew_diff_in_out
FROM dbp_view.v_flw_rauchverlust_2 v01;