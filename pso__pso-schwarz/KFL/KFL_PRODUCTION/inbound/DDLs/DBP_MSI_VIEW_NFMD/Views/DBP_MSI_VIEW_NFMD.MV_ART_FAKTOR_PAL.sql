CREATE OR REPLACE VIEW dbp_msi_view_nfmd.mv_art_faktor_pal
AS

SELECT DISTINCT
maw1.mandant_id,
maw1.art_id,

COALESCE(maw1.paletten_faktor_einh_id,'-') AS einh_pal,
marm_pal.umrech_zaehler / marm_pal.umrech_nenner AS faktor_pal

FROM DBP_VIEW.v_art mara
JOIN DBP_VIEW.v_art_vorschlagswert_per maw1
ON mara.mandant_id = maw1.mandant_id
AND mara.art_id     = maw1.art_id
AND maw1.dat_bis = '9999-12-31'
LEFT JOIN DBP_VIEW.v_art_umrechnung_faktor_per marm_pal
ON marm_pal.dat_bis             = '9999-12-31'
AND marm_pal.altnv_menge_einh_id = maw1.paletten_faktor_einh_id
AND marm_pal.mandant_id          = maw1.mandant_id
AND marm_pal.art_id              = maw1.art_id;