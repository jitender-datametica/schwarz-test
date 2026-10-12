--==============================================================
-- Table: l_eigenmarke_hfm_kz_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_eigenmarke_hfm_kz_2
   generated from Powerdesigner on Dienstag, 14. Februar 2023 16:42:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_eigenmarke_hfm_kz_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
eigenmarke_id STRING(2) NOT NULL OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)'),
hfm_markengruppe_kz STRING(20) NOT NULL
OPTIONS(description='Das HFM-Kennzeichen gibt an, um welche Art_2 von Marke es sich handelt. Aktuell gibt es für Eigenmarken folgende Markengruppen: MW - Mehrwert (bspw. Bio); PE - Preiseinstieg (günstige Marken); PR - Premium (höherwertige Marken); HM - Handelsmarke (speziell für KFL hergestellt); OK - Ohne Kennzeichen (hauptsächlich Non-Food). Da in der eigenmarke_id auch die Ausprägung "Fremdmarke" enthalten ist, gibt es auch hierfür zwei HFM-Kennzeichen: PE - Preiseinstieg; SO - Sonstige.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, eigenmarke_id) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle beinhaltet die Zuordnung der eigenmarken_id zu einer Markengruppe in HFM. Diese Information wird vom Einkauf geliefert und gruppiert vergleichbare Marken zu einem HFM-Kennzeichen.');