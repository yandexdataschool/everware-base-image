// --- //
define([
    'jquery',
    'base/js/namespace',
    'base/js/events'
], function ($, Jupyter, events) {
    var isGrade = function (cell) {
        if (cell.metadata.nbgrader === undefined) {
            return false;
        } else if (cell.metadata.nbgrader.grade === undefined) {
            return false;
        } else {
            return cell.metadata.nbgrader.grade;
        }
    };

    var isSolution = function (cell) {
        if (cell.metadata.nbgrader === undefined) {
            return false;
        } else if (cell.metadata.nbgrader.solution === undefined) {
            return false;
        } else {
            return cell.metadata.nbgrader.solution;
        }
    };

    var gradeElem = '<div style="padding: 5px 5px 5px 0; color: #f04040; font-weight: bold;">С оценкой:</div>';

    events.on('kernel_ready.Kernel', function () {
        var cells = Jupyter.notebook.get_cells();

        cells.forEach(function (cell) {
            if (isGrade(cell) || isSolution(cell)) {
                console.info(cell);

                var $cellElem = $(cell.element);

                $($cellElem.find('.inner_cell')).prepend(gradeElem);
            }
        });
    });
});
