/*
 * Main.fx
 *
 * Created on 24-mei-2010, 17:33:55
 */
package visualizationelements;
/**
 * @author Alex Sentcha
 */

import javafx.animation.Interpolator;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.Group;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.paint.Color;
import javafx.scene.Scene;
import javafx.scene.shape.Line;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.scene.control.Slider;


import visualizationelements.view.ImageButton;
import visualizationelements.Simulation;
import visualizationelements.model.Parameters;
import visualizationelements.model.InitParameters;

import visualizationelements.element.TankA;
import visualizationelements.element.TankC;
import visualizationelements.element.TankZ;
import visualizationelements.element.ControlValve;
import visualizationelements.element.Flowmeter;
import visualizationelements.element.Agitator;
import visualizationelements.element.ElectricValve;
import visualizationelements.element.Pump;
import visualizationelements.element.Alarm;
import visualizationelements.element.Conveyor;
import visualizationelements.element.Panel;
import visualizationelements.element.BucketElevator;


// Data type to be used in trasaction
var stageDragInitialX: Number;
var stageDragInitialY: Number;
// Application Bounds
var sceneWidth: Number = bind scene.width;
var sceneHeight: Number = bind scene.height;

// Element Details Index
var index: Integer = 0;
var simulation: Simulation;
var tankA: TankA;
var tankC: TankC;
var tankZ: TankZ;
var controlvalve: ControlValve;
var flowmeter: Flowmeter;
var agitator: Agitator;
var electricvalve: ElectricValve;
var pump: Pump;
var alarm: Alarm;
var conveyor: Conveyor;
var panel: Panel;
var bucketelevator: BucketElevator;

var element;
var elementarray: javafx.scene.Node[];
function addElements(){
    insert tankA into elementarray;
    insert tankC into elementarray;
    insert tankZ into elementarray;
    insert controlvalve into elementarray;
    insert flowmeter into elementarray;
    insert agitator into elementarray;
    insert electricvalve into elementarray;
    insert pump into elementarray;
    insert alarm into elementarray;
    insert conveyor into elementarray;
    insert panel into elementarray;
};
// Information about all relevant parameters
public var parameters: Parameters[];

function addSimulation() {
    simulation = Simulation{
        translateX: 0
        translateY: 0
    }
};
function addTankA() {
    tankA = TankA{
        translateX: bind (sceneWidth - 70) / 2.0
        translateY: bind sceneHeight  / 2.0 - 120
        name: bind "";
        value: bind if (simulation.Sim == true) then simulation.Level else slidervalue.value
        color: bind Color.TOMATO;
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};
function addTankC() {
    tankC = TankC{
        translateX: bind (sceneWidth - 40) / 2.0
        translateY: bind sceneHeight  / 2.0 - 80
        name: bind "";
        value: bind if (simulation.Sim == true) then simulation.Level else slidervalue.value
        color: bind Color.TOMATO;
//        scaleX : bind sliderscaleX.value;
//        scaleY : bind sliderscaleY.value;
    }
};
function addTankZ() {
    tankZ = TankZ{
        translateX: bind (sceneWidth - 60) / 2.0
        translateY: bind sceneHeight  / 2.0 - 90
        name: bind "";
        value: bind if (simulation.Sim == true) then (100-simulation.Level) else (100-slidervalue.value)
        color: bind Color.LIGHTSKYBLUE;
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};
function addControlValve() {
    controlvalve = ControlValve{
        translateX: bind (sceneWidth ) / 2.0
        translateY: bind sceneHeight  / 2.0 - 50
        name: bind "Control Valve";
        move: bind simulation.move;
        value: bind simulation.setpoint;
        colorC: bind Color.BLACK;
   }
};
function addFlowmeter() {
    flowmeter = Flowmeter{
        translateX: bind (sceneWidth ) / 2.0
        translateY: bind sceneHeight  / 2.0 - 50
        name: bind "Flowmeter";
        value: bind if (simulation.Sim == true) then simulation.Level else slidervalue.value
        colorf: bind Color.BLACK;
    }
};
function addAgitator() {
    agitator = Agitator{
        translateX: bind (sceneWidth  - 60) / 2.0
        translateY: bind sceneHeight  / 2.0 - 100
        name: bind "Agitator";
        color: bind Color.BLACK;
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};
function addElectricValve() {
    electricvalve = ElectricValve{
        translateX: bind (sceneWidth ) / 2.0
        translateY: bind sceneHeight  / 2.0 - 50
        name: bind "Electric Valve";
        color: bind Color.BLACK;
   }
};
function addPump() {
    pump = Pump{
        translateX: bind (sceneWidth  ) / 2.0
        translateY: bind sceneHeight  / 2.0 - 50
        name: bind "Pump";
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};
function addAlarm() {
    alarm = Alarm{
        translateX: bind (sceneWidth  ) / 2.0
        translateY: bind sceneHeight  / 2.0 - 50
        name: bind "Alarm";
        colorHL: Color.DARKRED;
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};
public function setAlarm(par: Boolean){
    alarm.SetAlarm(par);
};
function addConveyor() {
    conveyor = Conveyor{
        translateX: bind (sceneWidth  ) / 2.0
        translateY: bind sceneHeight  / 2.0 - 50
        name: bind "Conveyor";
        distance: bind 80;
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};
function addPanel() {
    panel = Panel{
        translateX: bind (sceneWidth  - 40 ) / 2.0
        translateY: bind sceneHeight  / 2.0 - 20
        name: bind "Panel";
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};
function addBucketElevator() {
    bucketelevator = BucketElevator{
        translateX: bind (sceneWidth  - 40 ) / 2.0
        translateY: bind sceneHeight  / 2.0 + 10
        name: bind "Bucket Elevator";
        distance: bind 80;
        scaleX : bind sliderscaleX.value;
        scaleY : bind sliderscaleY.value;
    }
};


// Background Image
function getBGImage(width: Integer, height: Integer): Image {
    var bounds = "{width}X{height}";
    if (bounds.equals("400X400") or bounds.equals("240X400") or bounds.equals("320X240") or bounds.equals("400X240")) {
        return Image {
                    url: "{__DIR__}images/background_{width}X{height}.png"
                }
    } else { //Unsupported dimension
        return null;
    }
}
var bgImage: ImageView = ImageView {
            focusTraversable: true
            image: bind getBGImage(sceneWidth, sceneHeight)
            onKeyPressed: function (e: KeyEvent) {
                if (e.code == KeyCode.VK_LEFT) {
                    onBack();
                } else if (e.code == KeyCode.VK_RIGHT) {
                    onNext();
                }            }
            onMouseClicked: function (e: MouseEvent) {
                bgImage.requestFocus();
            }
        }
// Display details of previous element in list
var backButton = ImageButton {
            x: 3
            y: bind (sceneHeight / 2.0 - 10)
            normalImage: Image {url: "{__DIR__}images/arrow_left_normal.png"}
            overImage: Image {url: "{__DIR__}images/arrow_left_over.png"}
            onMouseClicked: function (e) {
                onBack();
            }
        }

function onBack(): Void {
    if ((sizeof elementarray) == 0) {
        return ;
    }
    index--;
    if (index < 0) {
        index = ((sizeof elementarray) - 1);
    }
    showElementsDetails(index, false);
}
// Display details of next elements in list
var nextButton = ImageButton {
            x: bind (sceneWidth - 19)
            y: bind (sceneHeight / 2.0 - 10)
            normalImage: Image {url: "{__DIR__}images/arrow_right_normal.png"}
            overImage: Image {url: "{__DIR__}images/arrow_right_over.png"}
            onMouseClicked: function (e) {
                onNext();
            }
        }

function onNext(): Void {
    if ((sizeof elementarray) == 0) {
        return ;
    }
    index++;
    if (index >= (sizeof elementarray)) {
        index = 0;
    }
    showElementsDetails(index, true);
}
// Dispose Application
var closeButton = ImageButton {
            x: bind (sceneWidth - 20)
            y: 8
            normalImage: Image {url: "{__DIR__}images/x_normal.png"}
            overImage: Image {url: "{__DIR__}images/x_over.png"}
            visible: bind ("{__PROFILE__}" != "browser")
            onMouseClicked: function (e) {
                javafx.lang.FX.exit();
            }
        }


// Display details of elements at specified index in list
public function showElementsDetails(index: Integer, scrollLeft: Boolean): Void {

    if (index >= (sizeof elementarray)) {
        return ;
    }

    var scrollXVal = 1; // Scroll Right
    if (scrollLeft) {
        scrollXVal = -1;
    }
    shopDetailsX = 0;
     // Slide elements details animation
    var timeline: Timeline = Timeline {
                repeatCount: 1
                autoReverse: false
                rate: 1.0
                keyFrames: [
                    KeyFrame {
                        time: 250ms
                        values: [shopDetailsX => scrollXVal * sceneWidth tween Interpolator.LINEAR]
                        action: function () {
                            shopDetailsX = scrollXVal * -sceneWidth;
                            var result = parameters[index];
                            elementName = result.title;
                            parameter1 =  result.parameter1;
                            parameter2 =  result.parameter2;
                            parameter3 =  result.parameter3;
                            comments =  result.comment;
                            element = elementarray[index];
                            
                            title = "Visualization elements ({index + 1} of {sizeof elementarray})";
                            bgImage.requestFocus();
                        }
                    },
                    KeyFrame {
                        time: 250ms
                        values: [shopDetailsX => scrollXVal * -sceneWidth tween Interpolator.DISCRETE]
                    },
                    KeyFrame {
                        time: 500ms
                        values: [shopDetailsX => 0 tween Interpolator.LINEAR]
                    }
                ]
            };
    timeline.playFromStart();
}

// Trim the string if length is greater than specified length
function trimString(string: String, length: Integer): String {

    if (string == null)
        return "";
    if (string.length() > length) {
        return "{string.substring(0, length).trim()}...";
    } else {
        return string;
    }
}
// Star Rating Images
var defaultStarImage = Image {
            url: "{__DIR__}images/star0.png"
        }
var star = ImageView {
            x: 25
            y: 111
            image: defaultStarImage
            visible: false
        }
// Application Title
var titleBar = Rectangle {
            width: bind sceneWidth
            height: 25
            fill: Color.TRANSPARENT
            visible: bind ("{__PROFILE__}" != "browser")
            onMousePressed: function (e) {
                stageDragInitialX = e.screenX - stage.x;
                stageDragInitialY = e.screenY - stage.y;
            }
            onMouseDragged: function (e) {
                stage.x = e.screenX - stageDragInitialX;
                stage.y = e.screenY - stageDragInitialY;
            }
        }
var title = "Visualization elements JavaFX";
var titleText: Text = Text {
            translateX: bind (sceneWidth - titleText.boundsInLocal.width) / 2.0
            y: 18
            font: Font {name: "sansserif", size: 14}
            fill: Color.BLACK
            content: bind title
        }
// Divider
var divider = Line {
            startX: 0 startY: 25
            endX: bind sceneWidth endY: 25
            stroke: Color.rgb(138, 110, 72)
        }
// Element Name
var elementName = "";
var elementNameText = Text {
            x: 25
            y: 50
            font: Font {name: "sansserif", size: 13}
            fill: Color.BLACK
            content: bind elementName
        }
// parameter 1
var parameter1 = "";
var parameter1Text = Text {
            x: 25
            y: 68
            font: Font {name: "sansserif", size: 12}
            fill: Color.BLACK
            content: bind parameter1
        }
// parameter 2
var parameter2 = "";
var parameter2Text = Text {
            x: 25
            y: 86
            font: Font {name: "sansserif", size: 12}
            fill: Color.BLACK
            content: bind parameter2
        }
// parameter 3
var parameter3 = "";
var parameter3Text = Text {
            x: 25
            y: 104
            font: Font {name: "sansserif", size: 12}
            fill: Color.BLACK
            content: bind parameter3
        }
// comments
var comments = "";
var commentsText = Text {
            x: 25
            y: 260
            font: Font {name: "sansserif", size: 11}
            fill: Color.BLACK
            content: bind comments
            wrappingWidth: bind (sceneWidth - 60)
            textOrigin: TextOrigin.TOP
            clip: Rectangle {
                x: 23 y: 130
                width: bind sceneWidth
                height: bind (elementPanel.translateY - 137)
            }
        };
// Shop Details Group
var shopDetailsX: Number = 0;
var shopDetailsDisplay = Group {
            content: bind [
                element, elementNameText, parameter1Text, parameter2Text,parameter3Text
                , commentsText//, star
            ]
            translateX: bind shopDetailsX
        };
var shopDetailsGroup = Group {
            content: [shopDetailsDisplay]
            clip: Rectangle {
                x: 15
                y: 32
                width: bind (sceneWidth - 30)
                height: bind (sceneHeight - 64)
            }
        };
def sliderscaleX =  Slider {
            min: 1 max: 2 value: 1
//            showTickMarks: true
//            showTickLabels: true
            majorTickUnit: 1
            minorTickCount: 0.5
            blockIncrement: 0.01
 //           labelFormatter: function (num) {"{%(,.0f num}%"}
        };
def sliderscaleY =  Slider {
            min: 1 max: 2 value: 1
//            showTickMarks: true
//            showTickLabels: true
            majorTickUnit: 1
            minorTickCount: 0.5
            blockIncrement: 0.01
         };
def sliderrotation: Slider =  Slider {
            min: 0 max: 80 value: 46
//            showTickMarks: true
//            showTickLabels: true
            majorTickUnit: 5
            minorTickCount: 1
            blockIncrement: 1
        };
def slidervalue: Slider =  Slider {
            min: 0 max: 100 value: 50
//            showTickMarks: true
//            showTickLabels: true
            majorTickUnit: 10
            minorTickCount: 2
            blockIncrement: 1
         };
def dummy1: Number = bind slidervalue.value on replace {
                simulation.slidervalue = slidervalue.value;
                simulation.Level = slidervalue.value;
            };
def dummy2: Number = bind sliderrotation.value on replace {
                agitator.move = sliderrotation.value -40;
                pump.move = sliderrotation.value-40;
                conveyor.move = sliderrotation.value-40;
            };
def startButtonP = Button {
                text: " ON " action: function () {
                    agitator.startAgitator();
                    pump.start();
                    conveyor.start();
                    simulation.Sim = true;
                    electricvalve.openclose = true;
                    panel.OnOff = 30;
                    //alarm.colorHL = Color.RED;
                }
            };
def stopButtonP = Button {
                text: " OFF" action: function () {
                    agitator.stopAgitator();
                    pump.stop();
                    conveyor.stop();
                    simulation.Sim = false;
                    electricvalve.openclose = false;
                    panel.OnOff = 330;
                    //alarm.colorHL = Color.DARKRED;
                }
            };
def Col1 = VBox {
                spacing: 5
                content: bind [
                    Label {text: "Control:"  },
                    startButtonP, stopButtonP
                ]
            };

def Col2 = VBox {
                spacing: 5
                content: bind [
                    Label {text: "scale X"},
                    sliderscaleX,
                    Label {text: "scale Y"},
                    sliderscaleY
                ]
            };
def Col3 = VBox {
                spacing: 5
                content: bind [
                    Label {text: "control value                     "},
                    slidervalue,
                    Label {text: "rotation"},
                    sliderrotation
                ]
            };
def elementPanel: HBox = HBox {
            translateX: bind (sceneWidth - elementPanel.boundsInLocal.width) / 2.0
            translateY: bind (sceneHeight - 110)
            content: [ Col1, Col2, Col3]
            spacing: 10
        };
// Service Information
var serviceText: Text = Text {
            translateX: bind (sceneWidth - serviceText.boundsInLocal.width) / 2.0
            y: bind (sceneHeight - 10)
            font: Font {name: "sansserif", size: 11}
            fill: Color.rgb(96, 78, 51)
            content: "Custom components"
        }
var scene: Scene = Scene {
            content: Group {
                content: bind [
                    bgImage,
                    titleBar,
                    titleText,
                    divider,
                    shopDetailsGroup,
                    backButton,
                    nextButton,
                    closeButton,
                    elementPanel,
                    serviceText,
                    simulation,
                ]
                clip: Rectangle {
                    width: bind sceneWidth
                    height: bind sceneHeight
                    arcWidth: 20
                    arcHeight: 20
                }
            }
            fill: Color.TRANSPARENT
        }
// Application User Interface
var stage: Stage = Stage {
            title: "Visualization elements JavaFX 2010"
            resizable: false
            style: StageStyle.TRANSPARENT
            scene: bind scene
            width: 400
            height: 400
        }


function run()  {
    addTankA();
    addTankC();
    addTankZ();
    addSimulation();
    addControlValve();
    addFlowmeter();
    addAgitator();
    addElectricValve();
    addPump();
    addAlarm();
    addConveyor();
    addPanel();
    //addBucketElevator();
    addElements();
    InitParameters.addParameters();
    //addInfo();

    showElementsDetails(index,true);
    simulation.start();
    tankC.start();
    pump.start();
    conveyor.start();
    bucketelevator.Play();
    controlvalve.startRoer();
    agitator.startAgitator();

}


