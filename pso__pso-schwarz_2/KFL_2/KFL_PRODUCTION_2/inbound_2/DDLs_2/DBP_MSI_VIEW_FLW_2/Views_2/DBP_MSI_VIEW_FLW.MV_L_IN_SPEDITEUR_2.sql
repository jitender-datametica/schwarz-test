CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_SPEDITEUR_2
-- 24.01.2019 NAKU : Lookup fuer Spediteur da gleiche Stammdaten wie Lieferant (SPEC0039809)
-- 01.02.2019 NAKU: Der Joinweg ueber flw_lieferant_ekorg_zu_2 wird nicht benoetigt deswegen auskommentiert.

(
mandant_id
,spediteur_id
,spediteur_name
)
AS
   SELECT
   dt1.mandant_id, CAST (dt1.flw_lief_nr AS INTEGER) AS spediteur_id, cast(trim(dt1.lief_name_1) || ' ' ||  trim(dt1.lief_name_2)as varchar(161)) as spediteur_name -- beide Felder haben varchar(80)
   FROM dbp_view.v_flw_lieferant_2 dt1
   /*
   INNER JOIN dbp_view.v_flw_lieferant_ekorg_zu_2 dt2
   ON dt1.mandant_id = dt2.mandant_id
   AND dt1.flw_lief_id = dt2.flw_lief_id
   WHERE dt2.einkaufsorganisation_id IN (5000,5013)
   AND dt1.mandant_id in (1,2)
   */
   --pruefen ob flw_lief_nr INT, sonst ausfiltern (spediteur_id hat keine CHAR Elemente)
   --and
   where (CASE WHEN COALESCE(TRY_TO_NUMBER(dt1.flw_lief_nr),0) > 0 THEN 1 ELSE 0 END ) = 1;