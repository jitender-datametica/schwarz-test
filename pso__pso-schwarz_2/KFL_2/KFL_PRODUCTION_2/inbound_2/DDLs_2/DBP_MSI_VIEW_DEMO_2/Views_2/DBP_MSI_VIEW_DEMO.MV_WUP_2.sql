CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_WUP_2
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
vs_id,
gf_id,
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
TRIM(wup_id||' ' ||wup_standort) AS Markt,
(CASE WHEN dat_qbm_umstellung IS NOT NULL THEN 1 ELSE 0 END) AS qbm_id,
getraenkemarkt_fg,
vw_id,
buchungskreis_id,
verkaufsorganisation_id,
breitengrad,
laengengrad
FROM dbp_view.v_wup_2
WHERE nb_id IN (-2, -1, 0, 2, 7)  -- ZF, Filiale, Gastro, TKS
AND (dat_von > '2001' AND dat_eroeffnung > '2001')  -- Filterung wup_2 Sumpf
AND umzugsfiliale_fg = 0 -- ohne Umzugsfilialen (alt)
-- ohne Umzugsfilialen (alt)
;


