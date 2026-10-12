CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_AUFTRAG_1
--16.07.2019, mcie1607, added dat_buch and left outer join to mv_in_auftrag_rm_1
--12.12.2019, mcie1607, coalesce on buchungsdatum
(
 auftrag_id
,mandant_id
,auftragsart_id
,geschaeftsbereich_id
,in_budget_typ_id
,in_massnahme_typ_id
,auftrag_typ_id
,psp_id
,techn_platz_id
,werk_id
,phas_techn_abschluss_fg
,dat_buch
)
AS
   SELECT
    v01.auftrag_id, v01.mandant_id, v01.auftragsart_id, v01.geschaeftsbereich_id, v01.in_budget_typ_id, v01.in_massnahme_typ_id, v01.auftrag_typ_id, v01.psp_id, v01.techn_platz_id, v01.werk_id, v01.phas_techn_abschluss_fg, coalesce(Max(v02.dat_buch), Max(v03.dat_start)) AS dat_buch

   FROM dbp_view.v_in_auftrag_1 v01
   LEFT OUTER JOIN dbp_msi_view3.mv_in_auftrag_rm_1 v02
   ON v01.auftrag_id = v02.auftrag_id
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN dbp_msi_view3.mv_in_auftrag_pps_1 v03
   ON v01.auftrag_id = v03.auftrag_id
   AND v01.mandant_id = v03.mandant_id


   GROUP BY
    v01.auftrag_id
   ,v01.mandant_id
   ,v01.auftragsart_id
   ,v01.geschaeftsbereich_id
   ,v01.in_budget_typ_id
   ,v01.in_massnahme_typ_id
   ,v01.auftrag_typ_id
   ,v01.psp_id
   ,v01.techn_platz_id
   ,v01.werk_id
   ,v01.phas_techn_abschluss_fg;