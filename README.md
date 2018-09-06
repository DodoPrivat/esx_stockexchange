# esx_stockexchange
Stock Exchange
Script de bourse compatible avec esx_jobs ou esx_drugs
# Installation
Coté client lors de la vente : TriggerServerEvent('bourse:vente', 'vetement')
```sql
CREATE TABLE IF NOT EXISTS `bourse` (
  `item` varchar(50) NOT NULL,
  `stock` float NOT NULL,
  `prix` float NOT NULL,
  `prixbase` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `bourse` (`item`, `stock`, `prix`, `prixbase`) VALUES
('vetement', 20000, 23, 23);
```
