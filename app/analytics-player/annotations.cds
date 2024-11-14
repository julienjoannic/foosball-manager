using AnalyticsService as service from '../../srv/AnalyticsService';
annotate service.PlayerStatistics with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PlayerName,
            Label : 'Joueur',
        },
        {
            $Type : 'UI.DataField',
            Value : SeasonDescription,
            Label : 'Saison',
        },
        {
            $Type : 'UI.DataField',
            Value : GamesPlayed,
            Label : 'Matchs joués',
        },
        {
            $Type : 'UI.DataField',
            Value : GamesWon,
            Label : 'Matchs gagnés',
        },
        {
            $Type : 'UI.DataField',
            Value : GamesLost,
            Label : 'Matchs perdus',
        },
        {
            $Type : 'UI.DataField',
            Value : WinRate,
            Label : '% victoire',
        },
        {
            $Type : 'UI.DataField',
            Value : Gamelles,
            Label : 'Gamelles',
        },
        {
            $Type : 'UI.DataField',
            Value : GamellesPerGame,
            Label : 'Gamelles par match',
        },
        {
            $Type : 'UI.DataField',
            Value : Thomatines,
            Label : 'Thomatines',
        },
        {
            $Type : 'UI.DataField',
            Value : ThomatinesPerGame,
            Label : 'Thomatines par match',
        },
    ],
    Analytics.AggregatedProperty #WinRate_average : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'WinRate_average',
        AggregatableProperty : WinRate,
        AggregationMethod : 'average',
        ![@Common.Label] : '% victoire',
    },
    UI.Chart #alpChart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Dimensions : [
            PlayerName,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#WinRate_average',
            '@Analytics.AggregatedProperty#GamesPlayed_sum',
        ],
        DimensionAttributes : [
            {
                Dimension : PlayerName,
                Role : #Category,
            },
        ],
        Title : 'Statistiques par joueur',
    },
    Analytics.AggregatedProperty #GamesPlayed_sum : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'GamesPlayed_sum',
        AggregatableProperty : GamesPlayed,
        AggregationMethod : 'sum',
        ![@Common.Label] : 'Matchs joués',
    },
    UI.Chart #visualFilter : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bar,
        Dimensions : [
            PlayerName,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#WinRate_average',
        ],
    },
    UI.PresentationVariant #visualFilter : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.Chart#visualFilter',
        ],
    },
    UI.SelectionFields : [
        PlayerName,
        SeasonDescription,
    ],
    Analytics.AggregatedProperty #GamesPlayed_max : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'GamesPlayed_max',
        AggregatableProperty : GamesPlayed,
        AggregationMethod : 'max',
        ![@Common.Label] : 'Matchs joués',
    },
    UI.Chart #visualFilter1 : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bar,
        Dimensions : [
            SeasonDescription,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#GamesPlayed_sum',
        ],
    },
    UI.PresentationVariant #visualFilter1 : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.Chart#visualFilter1',
        ],
    },
);

annotate service.PlayerStatistics with {
    WinRate @Measures.Unit : '%'
};

annotate service.PlayerStatistics with {
    PlayerName @(
        Common.Label : 'Joueur',
        Common.ValueList #visualFilter : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'PlayerStatistics',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PlayerName,
                    ValueListProperty : 'PlayerName',
                },
            ],
            PresentationVariantQualifier : 'visualFilter',
        },
    )
};

annotate service.PlayerStatistics with {
    SeasonDescription @(
        Common.Label : 'Saison',
        Common.ValueList #visualFilter : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'PlayerStatistics',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : SeasonDescription,
                    ValueListProperty : 'SeasonDescription',
                },
            ],
            PresentationVariantQualifier : 'visualFilter1',
        },
    )
};

