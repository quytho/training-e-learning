module CoursesHelper
  def check_course_learned(course)
    if current_user.user_courses.find_by(course_id: course.id).blank?
      "Get started"
    elsif current_user.user_courses.find_by(course_id: course.id).is_learned
      "Completed"
    else 
      "Continue"
    end
  end

  def check_register_course(course)
    if !current_user || current_user.user_courses.find_by(course_id: course.id).blank?
      'disabled'
    end
  end

  def check_learned_lesson(lesson)
    if current_user && current_user.user_lessons.find_by(lesson_id: lesson.id).present?
      'list-group-item-success'
    end
  end
  
  def show_button_register_course(course)
    if current_user
      button_tag check_course_learned(course), class:"btn btn-primary btn-register #{check_course_learned(course)}",data: {course_id: course.id, user_id: current_user.id} 
    else
      link_to 'Get started',login_path, class:"btn btn-primary btn-register"
    end
  end

  def check_progress(course)
    if current_user
      "#{current_user.user_lessons.count} / #{course.lessons.length}"
    else
      "#{course.lessons.length}"
    end
  end
end
