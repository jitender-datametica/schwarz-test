CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_SENDUNG_HANDLINGUNIT_ZU_2
-- 23.05.2011  Alex Lipkin   Laut Konzept eindeutige Zuordnung ein Handling Unit_2
-- ist immer eindeutig einem Beols Vorgang (Sendung) zugeordnet und es existiert maxiaml einen Satz
-- in besch_lief_2
-- Nur Cross Docking Lieferungen werden aktuell  beruecksichtigt.
(

mandant_id
,belos_vorgang_id
,handling_unit_id_ext
)
AS
   SELECT mandant_id,
   belos_vorgang_id,
   handling_unit_id_ext
   FROM dbp_view.v_besch_lief_2
   WHERE lief_typ_id='YCD2' and wup_id_cd > -1

   -- Ausschluss von NULL Werten
   AND handling_unit_id_ext > '-1'  -- Chi: oder einfach IS NOT NULL
   AND belos_vorgang_id <> 0;