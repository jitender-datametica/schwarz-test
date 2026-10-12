--==============================================================
-- Table: l_iwt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_iwt
   generated from Powerdesigner on Mittwoch, 27. September 2023 15:37:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_IWT (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant    ',
   iwt_id                              VARCHAR(1)       NOT NULL COMMENT 'IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country for its own use (''''/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country (I)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_IWT PRIMARY KEY (mandant_id, iwt_id) NOT ENFORCED
)  COMMENT = 'VZ-Dispo IWT-Kennzeichen Lookup (DD07V Domname ZZEK_IWT).
             Table contains IDs that show if a product is ordered by KFL in one country for its own use (''''/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country (I)';
