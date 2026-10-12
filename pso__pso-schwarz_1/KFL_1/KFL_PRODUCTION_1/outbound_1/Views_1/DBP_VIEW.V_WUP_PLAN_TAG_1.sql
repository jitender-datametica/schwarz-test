CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_plan_tag_1 (wup_id
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), mandant_id
OPTIONS(description='Mandant_1 im DWH'), dat OPTIONS(description='Datum'), plan_tag_fg
OPTIONS(description='Wenn die Daten bereits in der SST auf der Ebene wup_1 und Tag_1 geliefert wurden: 1, sonst  0'),
umsatz_netto_plan OPTIONS(description='geplanter Nettoumsatz'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), umsatz_netto_plan_extern
OPTIONS(description='umsatz_netto_plan_extern. Upload aus Excel'), menge_absatz_ohne_pfand_plan
OPTIONS(description='Geplante Anzahl der zu verkaufenden Artikel_1 (ohne Pfand-Artikel_1) auf  Ebene Filiale/Tag.'))
OPTIONS(DESCRIPTION = `VIS - PLANWERTE PRO MARKT UND TAG_1`) AS SELECT wup_id,
 nb_id,
 mandant_id,
 dat,
 plan_tag_fg,
 umsatz_netto_plan,
 wrg_id,
 umsatz_netto_plan_extern,
 menge_absatz_ohne_pfand_plan
FROM kfl_production_dbp_data.wup_plan_tag_1;