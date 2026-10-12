--==============================================================
-- Table: l_eigenmarke_hfm_kz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_eigenmarke_hfm_kz
   generated from Powerdesigner on Dienstag, 14. Februar 2023 16:42:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_EIGENMARKE_HFM_KZ (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   eigenmarke_id                       VARCHAR(2)       NOT NULL COMMENT 'Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)',
   hfm_markengruppe_kz                 VARCHAR(20)      NOT NULL COMMENT 'Das HFM-Kennzeichen gibt an, um welche Art von Marke es sich handelt. Aktuell gibt es für Eigenmarken folgende Markengruppen: MW - Mehrwert (bspw. Bio); PE - Preiseinstieg (günstige Marken); PR - Premium (höherwertige Marken); HM - Handelsmarke (speziell für KFL hergestellt); OK - Ohne Kennzeichen (hauptsächlich Non-Food). Da in der eigenmarke_id auch die Ausprägung "Fremdmarke" enthalten ist, gibt es auch hierfür zwei HFM-Kennzeichen: PE - Preiseinstieg; SO - Sonstige.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_EIGENMARKE_HFM_KZ PRIMARY KEY (mandant_id, eigenmarke_id) NOT ENFORCED
)  COMMENT = 'Diese Tabelle beinhaltet die Zuordnung der eigenmarken_id zu einer Markengruppe in HFM. Diese Information wird vom Einkauf geliefert und gruppiert vergleichbare Marken zu einem HFM-Kennzeichen.';
