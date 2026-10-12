CREATE OR REPLACE VIEW dbp_data_center.tv_gfk_pruefpunkte_1
AS
SELECT
bes.fipo_bereich_id,
bes.fipo_bereich_bez,
ps.fipo_pruefpunkt_id,
p.fipo_pruefpunkt_typ,
ps.fipo_pruefpunkt_bez
FROM dbp_view.v_fipo_l_pruef_modul_1 pm_1

INNER JOIN dbp_view.v_fipo_pruef_modul_spr_zu_1 pms
ON pms.fipo_pruef_modul_id = pm.fipo_pruef_modul_id
AND pms.spr_id = 22
AND pms.fipo_pruef_modul_bez = 'Kundenfeedback'

INNER JOIN dbp_view.v_fipo_l_bereich_1 be
ON be.fipo_pruef_modul_id  = pm.fipo_pruef_modul_id

INNER JOIN dbp_view.v_fipo_bereich_spr_zu_1 bes
ON bes.fipo_bereich_id = be.fipo_bereich_id
AND bes.spr_id = 22

INNER JOIN dbp_view.v_fipo_l_kategorie_1 k
ON k.fipo_bereich_id = be.fipo_bereich_id

INNER JOIN dbp_view.v_fipo_kategorie_spr_zu_1 ks
ON ks.fipo_kategorie_id = k.fipo_kategorie_id
AND ks.spr_id = 22

INNER JOIN dbp_view.v_fipo_pruefpunkt_1 p
ON p.fipo_kategorie_id = k.fipo_kategorie_id
AND p.dat_von < CURRENT_DATE
AND p.dat_bis > CURRENT_DATE

INNER JOIN dbp_view.v_fipo_pruefpunkt_spr_zu_1 ps
ON ps.fipo_pruefpunkt_id = p.fipo_pruefpunkt_id
AND ps.spr_id = 22;
