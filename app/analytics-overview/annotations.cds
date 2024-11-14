using AnalyticsService as service from '../../srv/AnalyticsService';

annotate service.PlayerStatistics with @(
    Analytics.AggregatedProperty #ovwWinRateAverage : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'WinRate_average',
        AggregatableProperty : WinRate,
        AggregationMethod : 'average',
        ![@Common.Label] : '% victoire',
    },
    UI.Chart #ovwChartWinRate: {
        $Type : 'UI.ChartDefinitionType',
        Title : 'Statistiques par joueur',
        ChartType : #Bar,
        DimensionAttributes : [
            {
                $Type: 'UI.ChartDimensionAttributeType',
                Dimension: PlayerName,
                Role: #Category,
            }
        ],
        MeasureAttributes: [
            {
                $Type: 'UI.ChartMeasureAttributeType',
                DynamicMeasure: @Analytics.AggregatedProperty#ovwWinRateAverage,
                Role: #Axis1,
                DataPoint : '@UI.DataPoint#ovwDatapointWinRate'
            }
        ]
    },
    UI.PresentationVariant #ovwPresentationWinRate: {
        $Type             : 'UI.PresentationVariantType',
        Visualizations    : ['@UI.Chart#ovwChartWinRate'],
        MaxItems          : 10,
        IncludeGrandTotal : true,
        SortOrder         : [{
            $Type      : 'Common.SortOrderType',
            Descending : true,
            Property   : PlayerName
        }]
    },
    UI.DataPoint #ovwDatapointWinRate: {
        $Type                  : 'UI.DataPointType',
        Value                  : WinRate,
        Title                  : '% victoire',
        ValueFormat : {
            $Type : 'UI.NumberFormat',
            ScaleFactor : 100,
            NumberOfFractionalDigits : 2
        },
        TrendCalculation: {
            $Type                : 'UI.TrendCalculationType',
            ReferenceValue       : 100,
            UpDifference         : 5,
            StrongUpDifference   : 10,
            DownDifference       : -5,
            StrongDownDifference : -10
        },
    },
    UI.Identification: [{
        $Type : 'UI.DataField',
        Value : WinRate
    }]
);

annotate AnalyticsService.Games with @(
    UI.LineItem #ovwGamesTable : [
        {
            $Type : 'UI.DataField',
            Value : PlayedAtDate,
            Label : 'Date',
        },
        {
            $Type : 'UI.DataField',
            Value : Score,
            Label : 'Score',
        },
        {
            $Type : 'UI.DataField',
            Value : Color,
            Label : 'Couleur',
        },
    ],
    UI.SelectionVariant #ovwGamesTableSel: {
        $Type: 'UI.SelectionVariantType',
        Parameters: [
            {
                $Type: 'UI.Parameter',
                PropertyName: PlayerName,
                PropertyValue: PlayerName,
            }
        ]
    }
);