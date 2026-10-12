CREATE OR REPLACE VIEW dbp_msi_view_nfmd.mv_art_faktor_pal_2
AS

SELECT DISTINCT
maw1.mandant_id,
maw1.art_id,

COALESCE(maw1.paletten_faktor_einh_id,'-') AS einh_pal,
marm_pal.umrech_zaehler / marm_pal.umrech_nenner AS faktor_pal

FROM DBP_VIEW.v_art_2 mara_2
JOIN DBP_VIEW.v_art_vorschlagswert_per_2 maw1_2
ON mara.mandant_id = maw1.mandant_id
AND mara.art_id     = maw1.art_id
AND maw1.dat_bis = '9999-12-31'
LEFT JOIN DBP_VIEW.v_art_umrechnung_faktor_per_2 marm_pal
ON marm_pal.dat_bis             = '9999-12-31'
AND marm_pal.altnv_menge_einh_id = maw1.paletten_faktor_einh_id
AND marm_pal.mandant_id          = maw1.mandant_id
AND marm_pal.art_id              = maw1.art_id;