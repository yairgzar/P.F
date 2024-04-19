<script setup lang="ts">
import { computed } from 'vue';
import { useTheme } from 'vuetify';
import { getPrimary, getSecondary } from '@/utils/UpdateColors';
import { ref } from 'vue';

// common components
import BaseBreadcrumb from '@/components/shared/BaseBreadcrumb.vue';
import UiParentCard from '@/components/shared/UiParentCard.vue';
import UiChildCard from '@/components/shared/UiChildCard.vue';
// theme breadcrumb
const page = ref({ title: 'Dashboards' });
const breadcrumbs = ref([
    {
        text: '',
        disabled: false,
        href: '#'
    },
    {
        text: 'Column Chart',
        disabled: true,
        href: '#'
    },
    {
        text: '',
        disabled: false,
        href: '#'
    },
    {
        text: 'Radialbar & Radar',
        disabled: true,
        href: '#'
    },
    {
        text: 'Dashboard',
        disabled: false,
        href: '#'
    },
    {
        text: 'Area Chart',
        disabled: true,
        href: '#'
    }
]);

const theme = useTheme();
const chartOptions = computed(() => {
    return {
        chart: {
            type: 'bar',
            height: 350,
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
            toolbar: {
              show: false,
            },
        },
        colors: ['#6ac3fd', '#0b70fb', '#f64e60'],
        plotOptions: {
            bar: {
                horizontal: false,
                endingShape: 'rounded',
                columnWidth: '20%'
            }
        },
        dataLabels: {
            enabled: false,
        },
        stroke: {
            show: true,
            width: 2,
            colors: ['transparent']
        },

        xaxis: {
            categories: ['Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct']
        },
        yaxis: {
          title: {
            text: '$ (miles)',
          },
        },
        fill: {
            opacity: 1
        },
       
        tooltip: {
            theme: 'dark',
            y: {
              formatter(val:any) {
                return `$ ${val} miles`;
              },
            },
        },
        grid: {
          show: false,
        },
        legend: {
          show: true,
          position: 'bottom',
          width: '50px',
        },
        responsive: [
            {
                breakpoint: 600,
                options: {
                    yaxis: {
                        show: false
                    }
                }
            }
        ]
    };
    return {
        chart: {
            type: 'area',
            height: 300,
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
            zoom: {
                enabled: true
            },
            toolbar: {
                show: false
            }
        },
        colors: [getPrimary.value,getSecondary.value],
        dataLabels: {
            enabled: false
        },
        stroke: {
            width: '3',
            curve: 'smooth'
        },
        xaxis: {
            type: 'datetime',
            categories: [
                '2018-09-19T00:00:00',
                '2018-09-19T01:30:00',
                '2018-09-19T02:30:00',
                '2018-09-19T03:30:00',
                '2018-09-19T04:30:00',
                '2018-09-19T05:30:00',
                '2018-09-19T06:30:00',
            ]
        },
        yaxis: {
            opposite: false,
            labels: {
                show: true
            }
        },
        legend: {
            show: true,
            position: 'bottom',
            width: '50px'
        },
        grid: {
            show: false
        },
        tooltip: {
            theme: 'dark',
        }
    };
});

const areaChart = {
    series: [
        {
            name: 'Enero',
            data: [31, 40, 28, 51, 42, 109, 100]
        },
        {
            name: 'Febrero',
            data: [11, 32, 45, 32, 34, 52, 41]
        }
    ]
};

const columnChart = {
    series: [
        {
            name: 'Enero',
            data: [44, 55, 57, 56, 61, 58, 63, 60, 66]
        },
        {
            name: 'Febrero',
            data: [76, 85, 101, 98, 87, 105, 91, 114, 94]
        },
        {
            name: 'Marzo',
            data: [35, 41, 36, 26, 45, 48, 52, 53, 41]
        }
    ]
};




const success = theme.current.value.colors.success;
const accent = theme.current.value.colors.accent;
const warning = theme.current.value.colors.warning;

const radialBarchartOptions = computed(() => {
    return {
        chart: {
            type: 'radialBar',
            height: 300,
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
            toolbar: {
                show: false
            }
        },
        colors: ['#6ac3fd', '#0b70fb', '#f64e60', '#ffa800'],
        plotOptions: {
            radialBar: {
                dataLabels: {
                    name: {
                        fontSize: '22px'
                    },
                    value: {
                        fontSize: '16px'
                    },
                    total: {
                        show: true,
                        label: 'Total',
                        formatter() {
                            return 249;
                        }
                    }
                }
            }
        },
    };
});

const radialBarChart = {
    series: [44, 55, 67, 83]
};

const radarOptions = computed(() => {
    return {
        chart: {
            type: 'radar',
            height: 300,
            fontFamily: ``,
             toolbar: {
                    show: false,
                },
        },
        colors: ['#FF0000'],
        labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio'],
    };
});

const radarChart = {
    series: [
        {
            name: '',
            data: [80, 50, 30, 40, 100, 20],
        }
    ]
};
</script>

<template>
    <!-- ---------------------------------------------------- -->
    <!-- Column Chart -->
    <!-- ---------------------------------------------------- -->
    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <v-col cols="12">
            <UiParentCard title="">
                <apexchart type="bar" height="300" :options="chartOptions" :series="columnChart.series"> </apexchart>
            </UiParentCard>
        </v-col>
    </v-row>

    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <v-col cols="12">
            <v-row>
                <v-col cols="12" lg="6">
                    <!-- ---------------------------------------------------- -->
                    <!-- Radialbar Chart -->
                    <!-- ---------------------------------------------------- -->
                    <UiChildCard title="Radialbar Chart" class="bg-surface">
                        <apexchart type="radialBar" height="300" :options="radialBarchartOptions" :series="radialBarChart.series">
                        </apexchart>
                    </UiChildCard>
                </v-col>
                <v-col cols="12" lg="6">
                    <!-- ---------------------------------------------------- -->
                    <!-- Radar Chart -->
                    <!-- ---------------------------------------------------- -->
                    <UiChildCard title="" class="bg-surface">
                        <apexchart type="radar" height="300" :options="radarOptions" :series="radarChart.series"> </apexchart>
                    </UiChildCard>
                </v-col>
            </v-row>
        </v-col>
    </v-row>

    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <v-col cols="12">
            <UiParentCard title="Area Chart">
                <apexchart type="area" height="300" :options="chartOptions" :series="areaChart.series"> </apexchart>
            </UiParentCard>
        </v-col>
    </v-row>
</template>
