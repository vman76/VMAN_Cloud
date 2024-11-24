@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'VMAN - Airports with Access control'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZVMAN_AIRPORTS as select from /dmo/airport
{
    key airport_id as airport_id,
    name as name,
    city as city,
    country as country 
}
