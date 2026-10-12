CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wup -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage

AS
SELECT
wup_id,
nb_id,
mandant_id,
land_id,
dat_von,
wup_typ_id,
wup_name_v,
wup_name_e,
wup_standort,
wup_plz,
wup_str,
vf_id,
vkl_id,
hl_id,
dat_bis,
uebernahme_von,
breakevenumsatz,
systemrentabilitaet,
verkaufsflaeche,
betriebsflaeche,
fleischsystem,
preiskategorie_food,
preiskategorie_nonfood,
sortkategorie_food,
sortkategorie_nonfood,
sondermarkt,
ref_wup_id,
wm_id,
kassentyp,
dat_qbm_umstellung,
lead_mwst,
region_id,
kundenfaktor,
vz_wup_id,
CASE
WHEN dat_qbm_umstellung IS NOT NULL THEN 1
ELSE 0 END AS qbm_id,
getraenkemarkt_fg,
CASE
WHEN (mandant_id <> 1 AND vs_id IS NULL) THEN 0
WHEN (mandant_id = 1 AND wup_id=6902) THEN 3
WHEN (mandant_id = 1 AND wup_id=6903) THEN 1
WHEN (mandant_id = 1 AND wup_id=6905) THEN 2
WHEN (mandant_id = 1 AND wup_id=6906) THEN 7
WHEN (mandant_id = 1 AND wup_id=6908) THEN 6
WHEN (mandant_id = 1 AND wup_id=6909) THEN 8
ELSE vs_id END AS vs_id,
buchungskreis_id,
verkaufsorganisation_id,
breitengrad,
laengengrad
FROM dbp_view.v_wup;