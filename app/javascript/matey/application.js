import { Application } from "@hotwired/stimulus"
import ChartController from "matey/controllers/chart_controller"

const application = Application.start()
application.register("chart", ChartController)
