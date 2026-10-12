/* --------------------------------------------------------------------------------
   DDL for table: t_assortment_container_1
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ASSORTMENT_CONTAINER_1 (
   assortment_container_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key container.
            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and 
            T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL
            ',
   container_client_id                 NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT
            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY ',
   assortment_container_nr             NUMBER(38,0)     NOT NULL COMMENT 'identifier of the assortment container in the source system
            WAWI:T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ASSORTMENT_CONTAINER PRIMARY KEY (assortment_container_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. assortment container, virtual container to allow warehouses to modularize the assortment
             WAWI: T1041_ITEMCONTAINER_HEAD_1';

