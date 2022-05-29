'use strict';

export async function createLine(selector, labels, series)
{
    new Chartist.Line(selector, {labels, series: [series]});
}