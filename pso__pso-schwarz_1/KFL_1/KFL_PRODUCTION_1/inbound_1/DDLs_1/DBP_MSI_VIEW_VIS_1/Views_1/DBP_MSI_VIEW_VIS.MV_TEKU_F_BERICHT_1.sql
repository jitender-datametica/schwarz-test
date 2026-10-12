CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_F_BERICHT_1
-- 20.02.2015 srom: ANF 610089, Anpassungen wegen Änderung Datenmodell
-- 09.03.2015 srom: Umstellung Berechnungslogik der Bereichsnote/Gesamtnoten
-- 19.03.2015 srom: ANF 602298, nicht_auswerten_fg
(
teku_bericht_id
,dat_besuchs_beginn
,zeit_besuchs_beginn
,dat_besuchs_ende
,zeit_besuchs_ende
,mandant_id
,wup_id
,teku_checkliste_id
,frische_fg
,einsatzzeit
)
AS
   SELECT
   tb.teku_bericht_id, tb.dat_besuchs_beginn, tb.zeit_besuchs_beginn, tb.dat_besuchs_ende, tb.zeit_besuchs_ende, tb.mandant_id, tb.wup_id, tc.teku_checkliste_id, tc.frische_fg
  -- , (EXTRACT ( DAY FROM ( CAST(tb.dat_besuchs_ende || ' ' || tb.zeit_besuchs_ende AS TIMESTAMP) - CAST(tb.dat_besuchs_beginn || ' ' || tb.zeit_besuchs_beginn AS TIMESTAMP) DAY(4) TO SECOND)) * 86400) +
  -- (EXTRACT ( HOUR FROM ( CAST(tb.dat_besuchs_ende || ' ' || tb.zeit_besuchs_ende AS TIMESTAMP) - CAST(tb.dat_besuchs_beginn || ' ' || tb.zeit_besuchs_beginn AS TIMESTAMP) DAY(4) TO SECOND)) * 3600) +
  -- (EXTRACT ( MINUTE FROM ( CAST(tb.dat_besuchs_ende || ' ' || tb.zeit_besuchs_ende AS TIMESTAMP) - CAST(tb.dat_besuchs_beginn || ' ' || tb.zeit_besuchs_beginn AS TIMESTAMP) DAY(4) TO SECOND)) * 60) +
  -- (EXTRACT ( SECOND FROM ( CAST(tb.dat_besuchs_ende || ' ' || tb.zeit_besuchs_ende AS TIMESTAMP) - CAST(tb.dat_besuchs_beginn || ' ' || tb.zeit_besuchs_beginn AS TIMESTAMP) DAY(4) TO SECOND)))::INTEGER AS einsatzzeit
, datediff(second, cast(tb.dat_besuchs_beginn || ' ' || tb.zeit_besuchs_beginn  as timestamp),cast(tb.dat_besuchs_ende || ' ' || tb.zeit_besuchs_ende  as timestamp) ) as  einsatzzeit


   FROM dbp_view.v_teku_bericht_per_1 tb
   INNER JOIN dbp_view.v_l_teku_checkliste_1 tc
   ON tb.teku_checkliste_id = tc.teku_checkliste_id

   WHERE tb.dat_bis  = '9999-12-31'
   -- gelöschte TeKu-Berichte werden in den DWH Berichten nicht ausgewertet
   AND tb.loeschung_fg = 0
   -- Es gibt TeKu-Berichte, die nicht in die DWH Auswertung einfließen dürfen. In READ gibt es flexible Berichte, die alle Daten anzeigen dürfen.
   -- Daher ist in DWH-READ ein entsprechender Berichtsfilter verbaut und nicht in der View-Where Bedingung enthalten
   AND tb.nicht_auswerten_fg = 0;