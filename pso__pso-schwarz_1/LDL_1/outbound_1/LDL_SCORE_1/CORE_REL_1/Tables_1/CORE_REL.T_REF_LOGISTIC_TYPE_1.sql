--==============================================================
-- Table: t_ref_logistic_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_logistic_type_1
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 09:20:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_logistic_type_1 (
logistic_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistics, e.g. Direct- or Collective logistics.'),
logistic_type_descr STRING(100) NOT NULL
OPTIONS(description='Komplettladung or Direct logistics describes the direct transport from a supplier_1 to the central warehouse of the regional company. It is an uninterrupted logistics chain. The items are not transshipped within the cross-docks or import warehouses.            Sammelladung or Sammellogistikrefers to the consolidation of quantities through the Lidl network in order to transport the items cost-effectively, among other things. Also known as groupage,sammelladung describes  transports that are handled via a cross-dock. This means that at least one cross-dock is included in the transport route.'),
logistic_type_descr_de STRING(100)
OPTIONS(description='A textual description for the logistics_type_cd written out in German.'),
logistic_type_descr_en STRING(100)
OPTIONS(description='A textual description for the logistics_type_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (logistic_type_cd) NOT ENFORCED
)
OPTIONS(description='Represents the type of logistics is conducted.              The most common types are SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik).              In the first case the goods are picked up from a supplier_1 or the supplier_1 delivers directly to a crossdock.             Next, the goods are delivered to various crossdocks till the last one. From this point the last destination of the products is a Lidl warehouse.              The other case would be, that the supplier_1 delivers the products directly to the Lidl warehouse = DL. ');