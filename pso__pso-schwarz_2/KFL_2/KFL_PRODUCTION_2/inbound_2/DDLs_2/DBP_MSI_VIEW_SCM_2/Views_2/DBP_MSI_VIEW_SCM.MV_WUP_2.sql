CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_wup_2
--- Hier gibt es keine Unterscheidung zwischen Markt, Verteilzentrum etc. In Microstrategy werden Filter auf nb_id oder fest verdrahtete wup_id verwendet
--- 2020-03-16 nwag2310: add left join for Frische-Manager
--- 2020-08-28 nwag2310: added wup_id -9 dummy_2 for decentral products in WBS
--- 2020-09-08 nwag2310, changed nb_id to 0 for wup_id=-1
--- 2021-07-30 srom0404, formatting and discussed with N. Wagner, qualify to Verteilzentrum (nb_id = -111) 
AS
SELECT
t0.wup_id,
CASE
WHEN t0.wup_id=-1 THEN 0
ELSE t0.nb_id END AS nb_id,
t0.mandant_id,
t0.land_id,
t0.dat_von,
t0.wup_typ_id,
t0.wup_name_v,
t0.wup_name_e,
t0.wup_standort,
t0.wup_plz,
t0.wup_str,
t0.vf_id,
t0.vkl_id,
t0.hl_id,
t0.dat_bis,
t0.uebernahme_von,
t0.breakevenumsatz,
t0.systemrentabilitaet,
t0.verkaufsflaeche,
t0.betriebsflaeche,
t0.fleischsystem,
t0.preiskategorie_food,
t0.preiskategorie_nonfood,
t0.sortkategorie_food,
t0.sortkategorie_nonfood,
t0.sondermarkt,
t0.ref_wup_id,
t0.wm_id,
t0.kassentyp,
t0.dat_qbm_umstellung,
t0.lead_mwst,
t0.region_id,
t0.kundenfaktor,
t0.vz_wup_id,
(CASE
WHEN t0.dat_qbm_umstellung IS NOT NULL THEN 1
ELSE 0 END) AS qbm_id,
t0.getraenkemarkt_fg,
(CASE
WHEN (t0.mandant_id<>1 AND t0.vs_id IS NULL) THEN 0
WHEN (t0.mandant_id=1 AND t0.wup_id=6902) THEN 3
WHEN (t0.mandant_id=1 AND t0.wup_id=6903) THEN 1
WHEN (t0.mandant_id=1 AND t0.wup_id=6905) THEN 2
WHEN (t0.mandant_id=1 AND t0.wup_id=6906) THEN 7
WHEN (t0.mandant_id=1 AND t0.wup_id=6908) THEN 6
WHEN (t0.mandant_id=1 AND t0.wup_id=6909) THEN 8
ELSE t0.vs_id END) AS vs_id,
t0.buchungskreis_id,
t0.verkaufsorganisation_id,
t0.breitengrad,
t0.laengengrad,
t1.frische_manager_id
FROM dbp_view.v_wup_2 t0
LEFT OUTER JOIN dbp_msi_v_view.v_wup_denorm_2 t1_2
ON t0.mandant_id = t1.mandant_id
AND t0.wup_id = t1.wup_id
WHERE nb_id = -111

UNION ALL
SELECT
-9 AS wup_id,
-111 AS nb_id,
m.mandant_id AS mandant_id,
m.mandant_kbez AS land_id,
DATE '1900-01-01' AS dat_von,
2 AS wup_typ_id,
'' AS wup_name_v,
'Dezentral / Decentral' AS wup_name_e,
'Dezentral / Decentral' AS wup_standort,
'00000' AS wup_plz,
'' AS wup_str,
0 AS vf_id,
-1 AS vkl_id,
NULL AS hl_id,
DATE '9999-12-31' AS dat_bis,
'' AS uebernahme_von,
0 AS breakevenumsatz,
0 AS systemrentabilitaet,
0 AS verkaufsflaeche,
0 AS betriebsflaeche,
0 AS fleischsystem,
NULL AS preiskategorie_food,
NULL AS preiskategorie_nonfood,
NULL AS sortkategorie_food,
NULL AS sortkategorie_nonfood,
NULL AS sondermarkt,
0 AS ref_wup_id,
-1 AS wm_id,
'' AS kassentyp,
DATE '2709-12-31' AS dat_qbm_umstellung,
NULL AS lead_mwst,
NULL AS region_id,
1 AS kundenfaktor,
NULL AS vz_wup_id,
1 AS qbm_id,
0 AS getraenkemarkt_fg,
0 AS vs_id,
NULL AS buchungskreis_id,
'' AS verkaufsorganisation_id,
NULL AS breitengrad,
NULL AS laengengrad,
NULL AS frische_manager_id
FROM dbp_view.v_mandant_2 m

UNION ALL
SELECT
-1 AS wup_id,
-111 AS nb_id,
m.mandant_id AS mandant_id,
m.mandant_kbez AS land_id,
DATE '1900-01-01' AS dat_von,
2 AS wup_typ_id,
'' AS wup_name_v,
'--' AS wup_name_e,
'--' AS wup_standort,
'00000' AS wup_plz,
'' AS wup_str,
0 AS vf_id,
-1 AS vkl_id,
NULL AS hl_id,
DATE '9999-12-31' AS dat_bis,
'' AS uebernahme_von,
0 AS breakevenumsatz,
0 AS systemrentabilitaet,
0 AS verkaufsflaeche,
0 AS betriebsflaeche,
0 AS fleischsystem,
NULL AS preiskategorie_food,
NULL AS preiskategorie_nonfood,
NULL AS sortkategorie_food,
NULL AS sortkategorie_nonfood,
NULL AS sondermarkt,
0 AS ref_wup_id,
-1 AS wm_id,
'' AS kassentyp,
DATE '2709-12-31' AS dat_qbm_umstellung,
NULL AS lead_mwst,
NULL AS region_id,
1 AS kundenfaktor,
NULL AS vz_wup_id,
1 AS qbm_id,
0 AS getraenkemarkt_fg,
0 AS vs_id,
NULL AS buchungskreis_id,
'' AS verkaufsorganisation_id,
NULL AS breitengrad,
NULL AS laengengrad,
NULL AS frische_manager_id
FROM dbp_view.v_mandant_2 m;