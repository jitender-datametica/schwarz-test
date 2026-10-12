CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VAUS_WUP
-- 14.01.2012 AL buchungskreis_id aus vaus_wup anstatt wup nehmen
(
mandant_id
,nb_id
,land_id
,wup_id
,buchungskreis_id
,telefon
,telefax
,betriebsrat_fg
,auflage_wup_verteilgebiet
,auflage_wup_auslage
,vaus_wup_plz
,vaus_wup_strasse
,vaus_wup_stadt
,vaus_wup_name
)
AS
SELECT
v01.mandant_id, v01.nb_id, v01.land_id, v01.wup_id, COALESCE(v02.buchungskreis_id, -1)  AS buchungskreis_id, v02.wup_telefon AS telefon, v02.wup_fax  AS telefax, COALESCE(v02.betriebsrat_fg,-1) AS betriebsrat_fg, v02.auflage_wup_verteilgebiet, v02.auflage_wup_auslage, v02.wup_plz AS vaus_wup_plz, v02.wup_str AS vaus_wup_strasse, v02.wup_stadt_1 AS vaus_wup_stadt, COALESCE(v02.wup_name_1,'') AS vaus_wup_name

FROM dbp_view.v_wup  v01
LEFT JOIN dbp_view.v_vaus_wup  v02
ON v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id

WHERE v01.nb_id IN (-2, -1, 0, 2, 7)
AND v01.dat_eroeffnung > CAST('1900-01-01' AS DATE);