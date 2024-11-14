using UserService as service from '../../srv/UserService';
using from '../../db/schema';


annotate service.Games with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Date/heure',
            Value : PlayedAt
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : Teams.Score,
            Label : 'Score',
        },
        {
            $Type : 'UI.DataField',
            Value : Teams.Player.Name,
            Label : 'Joueurs'
        },
        {
            $Type : 'UI.DataField',
            Value : WinningTeamColor,
            Label : 'Equipe victorieuse',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Match',
        TypeNamePlural : 'Matchs',
        Title : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    },
    Analytics.AggregatedProperty #ID_countdistinct : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'ID_countdistinct',
        AggregatableProperty : ID,
        AggregationMethod : 'countdistinct',
        ![@Common.Label] : 'Nombre de matchs',
    },
    UI.Chart #alpChart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bar,
        Dimensions : [
            PlayedAt,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#ID_countdistinct',
        ],
        Title : 'Matchs joués',
    },
    UI.Chart #visualFilter : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bar,
        Dimensions : [
            PlayedAt,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#ID_countdistinct',
        ],
    },
    UI.PresentationVariant #visualFilter : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.Chart#visualFilter',
        ],
    },
    UI.SelectionFields : [
        PlayedAtDate,
        Table_ID,
        Teams.Player_ID,
    ],
    UI.Chart #alpChart1 : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Dimensions : [
            PlayedAtDate,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#ID_countdistinct',
        ],
        DimensionAttributes : [
            {
                Dimension : PlayedAtDate,
            },
        ],
    },
);

annotate service.Games with {
    Table @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Tables',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Table_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Brand',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Model',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Location',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Description',
                },
            ],
        },
        Common.Text : {
            $value : Table.Description,
            ![@UI.TextArrangement] : #TextOnly
        },
        Common.FieldControl : #Mandatory,
        Common.Label : 'Baby-foot',
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Games with {
    Teams @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'GameTeams',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Color',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Score',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Thomatines',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Gamelles',
            },
        ],
    }
};

annotate service.Games with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Date/heure',
                Value : PlayedAt,
            },
            {
                $Type : 'UI.DataField',
                Value : Table_ID,
                Label : 'Baby-foot',
            },
            {
                $Type : 'UI.DataField',
                Value : Season_ID,
                Label : 'Saison',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Données générales',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Equipes',
            ID : 'Equipes',
            Target : 'Teams/@UI.LineItem#Equipes',
        },
    ]
);
annotate service.GameTeams with @(
    UI.LineItem #Equipes : [
        {
            $Type : 'UI.DataField',
            Value : Player_ID,
            Label : 'Joueur',
        },
        {
            $Type : 'UI.DataField',
            Value : Color,
            Label : 'Couleur',
        },
        {
            $Type : 'UI.DataField',
            Value : Score,
            Label : 'Score',
        },
        {
            $Type : 'UI.DataField',
            Value : Gamelles,
            Label : 'Gamelles',
        },
        {
            $Type : 'UI.DataField',
            Value : Thomatines,
            Label : 'Thomatines',
        },
    ]
);

annotate service.GameTeams with {
    Player @(
        Common.Text : {
            $value : Player.Name,
            ![@UI.TextArrangement] : #TextOnly
        },
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Players',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Player_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #Mandatory,
        Common.Label : 'Joueur',
    )
};

annotate service.Players with {
    ID @Common.Text : {
        $value : Name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.Games with {
    PlayedAt @(
        Common.FieldControl : #Mandatory,
        Common.Label : 'Date',
        )
};

annotate service.GameTeams with {
    Score @Common.FieldControl : #Mandatory
};

annotate service.Games with @Aggregation.ApplySupported: {
    Transformations: [
        'aggregate',
        'topcount',
        'bottomcount',
        'identity',
        'concat',
        'groupby',
        'filter',
        'search'
    ],
    Rollup: #None,
    PropertyRestrictions: true,
    GroupableProperties: [
        PlayedAtDate,
        Table_ID
    ],
    AggregatableProperties: [
        {Property: ID, }
    ]
};
annotate service.Tables with {
    ID @Common.Text : Description
};

annotate service.Games with {
    PlayedAtDate @Common.Label : 'Date du match'
};

annotate service.Games with {
    Season @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Seasons',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Season_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #ReadOnly,
        Common.Text : {
            $value : Season.Description,
            ![@UI.TextArrangement] : #TextOnly
        },
)};

annotate service.Seasons with {
    ID @Common.Text : Description
};


