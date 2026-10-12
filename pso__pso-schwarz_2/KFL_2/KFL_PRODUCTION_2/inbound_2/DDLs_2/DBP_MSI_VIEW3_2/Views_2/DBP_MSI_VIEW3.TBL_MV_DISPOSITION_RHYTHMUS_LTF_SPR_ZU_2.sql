CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_DISPOSITION_RHYTHMUS_LTF_SPR_ZU_2
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
-- 26.09.2018, AP0018098 - Disporhythmus, srom0404, Erweiterung -1 = nicht gepflegt
(
mandant_id
,spr_id
,disposition_rhythmus_ltf_id
,disposition_rhythmus_ltf_id_bez
,disposition_rhythmus_ltf_bez
)
AS
   SELECT
   v01.mandant_id, v01.spr_id, v01.disposition_rhythmus_ltf_id, CAST(v01.disposition_rhythmus_ltf_id AS CHAR(14)) AS disposition_rhythmus_ltf_id_bez, v01.disposition_rhythmus_ltf_bez
   FROM dbp_view.v_disposition_rhythmus_ltf_spr_zu_2 v01
--    INNER JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
--    ON v01.spr_id = v02.spr_id

   UNION

   SELECT
   t01.mandant_id, t01.spr_id, t01.disposition_rhythmus_ltf_id, t01.disposition_rhythmus_ltf_id_bez, t01.disposition_rhythmus_ltf_bez
   FROM
   ( --t01
   SELECT v01.mandant_id, v02.spr_id, '-1' AS disposition_rhythmus_ltf_id, CAST('nicht gepflegt' AS CHAR(14)) AS disposition_rhythmus_ltf_id_bez, 'nicht gepflegt' AS disposition_rhythmus_ltf_bez
   FROM dbp_view.v_mandant_2 v01
   CROSS JOIN dbp_view.v_mandant_spr_zu_2 v02
   ) t01;