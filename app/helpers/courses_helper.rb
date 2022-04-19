module CoursesHelper
  def check_course_learned(course)
    if course.user_courses.blank?
      "Get started"
    elsif course.user_courses.find_by(course_id: course.id).is_learned
      "Completed"
    else
      "Continue"
    end
  end
end
