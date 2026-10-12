CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_ABSAGEGRUND_1
-- 18.09.2015 twie: Dummywert -1 dazu

(
mandant_id
, absagegrund_id
)
AS
   SELECT

   v01.mandant_id, v01.absagegrund_id

   FROM dbp_view.v_flw_l_absagegrund_1 v01

   UNION

   SELECT

   v02.mandant_id, '-1' AS absagegrund_id

   FROM dbp_view.v_mandant_1 v02
   WHERE v02.mandant_id IN (1,2);