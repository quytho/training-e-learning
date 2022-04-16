module CoursesHelper
  def checkCourseLearned(course)
    if course.user_courses.blank?
      button = link_to "Get started",'#', remote: true, class:"btn btn-primary"
    elsif course.user_courses.find_by(course_id: course.id).is_learned
      button = link_to "Completed",'#', remote: true, class:"btn btn-success"
    else
      button = link_to "Continue",'#', remote: true, class:"btn btn-info"
    end
  end
end
