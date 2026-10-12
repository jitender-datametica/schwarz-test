CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_aenderung_grund_spr_zu (wup_aenderung_grund_id
OPTIONS(description='Numerischer Code fuer den Grund der WUP ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup ID.Moegliche Auspraegungen:0 = keine Aenderung1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)2 = Umzug (seit Einfuehrung der Filialumgliederungen)3 = Umgliederung4 = Abriss / Neubau'),
spr_id OPTIONS(description='ID der Sprache'), wup_aenderung_grund_bez
OPTIONS(description='Bezeichnung des Änderungsgrundes der WUP ID in jeweiliger Sprache.'))
OPTIONS(DESCRIPTION = `Zuordnungstabelle zwischen den Änderungsgrunde der WUP ID und der Sprache. Beinhaltet von der Sprache abhängige Bezeichnungen der Gründe.`)
AS SELECT wup_aenderung_grund_id,
 spr_id,
 wup_aenderung_grund_bez
FROM kfl_production_dbp_data.wup_aenderung_grund_spr_zu;