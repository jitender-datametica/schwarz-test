CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_ART_GP_ZU_PER_1
AS
SELECT
art_id,
gp_id,
mandant_id,
herst_id,
gp_art_id,
MAX(dat_von) AS dat_von,
MAX(dat_bis) AS dat_bis
FROM dbp_view.v_art_gp_zu_per_1
WHERE dat_bis = '9999-12-31'
GROUP BY
art_id
, gp_id
, mandant_id
, herst_id
, gp_art_id;


-- LOOKUP : Hauptwarengruppe
-- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)
